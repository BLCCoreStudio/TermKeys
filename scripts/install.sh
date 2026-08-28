#!/bin/sh

set -eu

REPOSITORY="BLCCoreStudio/TermKeys"
RELEASES_API="https://api.github.com/repos/${REPOSITORY}/releases?per_page=20"
INSTALL_DIR="${HOME:-}/.local/bin"
INSTALL_PATH="${INSTALL_DIR}/termkeys"
DRY_RUN=0
TMP_DIR=""
STAGED_PATH=""

log() {
    printf '%s\n' "[TermKeys] $*"
}

fail() {
    printf '%s\n' "[TermKeys] ERROR: $*" >&2
    exit 1
}

cleanup() {
    if [ -n "$STAGED_PATH" ] && [ -e "$STAGED_PATH" ]; then
        rm -f "$STAGED_PATH"
    fi

    if [ -n "$TMP_DIR" ] && [ -d "$TMP_DIR" ]; then
        rm -rf "$TMP_DIR"
    fi
}

trap cleanup EXIT HUP INT TERM

usage() {
    cat <<'USAGE'
Usage: sh scripts/install.sh [--dry-run]

Downloads the newest published TermKeys Linux x86_64 release from GitHub,
verifies its SHA-256 checksum, and installs the binary to ~/.local/bin/termkeys.

Options:
  --dry-run   Validate the local platform and print the planned actions only.
  -h, --help  Show this help text.
USAGE
}

case "${1:-}" in
    "")
        ;;
    --dry-run)
        DRY_RUN=1
        ;;
    -h|--help)
        usage
        exit 0
        ;;
    *)
        usage >&2
        fail "Unknown argument: $1"
        ;;
esac

[ -n "${HOME:-}" ] || fail "HOME is not set; cannot determine ~/.local/bin."

OS_NAME="$(uname -s 2>/dev/null || true)"
ARCH_NAME="$(uname -m 2>/dev/null || true)"

[ "$OS_NAME" = "Linux" ] || fail "TermKeys public releases currently support Linux only (detected: ${OS_NAME:-unknown})."

case "$ARCH_NAME" in
    x86_64|amd64)
        ;;
    *)
        fail "TermKeys public releases currently support Linux x86_64 only (detected: ${ARCH_NAME:-unknown})."
        ;;
esac

if [ "$DRY_RUN" -eq 1 ]; then
    log "Dry run: platform is Linux x86_64."
    log "Dry run: would query GitHub Releases for the newest TermKeys Linux x86_64 asset."
    log "Dry run: would download the release archive and matching SHA256SUMS.txt."
    log "Dry run: would verify SHA-256 before extracting or installing anything."
    log "Dry run: would install only to $INSTALL_PATH."
    log "Dry run: no files were downloaded or changed."
    exit 0
fi

command -v curl >/dev/null 2>&1 || fail "curl is required to download TermKeys from GitHub Releases."
command -v tar >/dev/null 2>&1 || fail "tar is required to extract the TermKeys release archive."
command -v awk >/dev/null 2>&1 || fail "awk is required to verify the release checksum."
command -v sed >/dev/null 2>&1 || fail "sed is required to identify the release asset."
command -v grep >/dev/null 2>&1 || fail "grep is required to validate the release archive."
command -v find >/dev/null 2>&1 || fail "find is required to locate the TermKeys binary in the verified archive."

if command -v sha256sum >/dev/null 2>&1; then
    SHA256_COMMAND="sha256sum"
elif command -v shasum >/dev/null 2>&1; then
    SHA256_COMMAND="shasum"
else
    fail "sha256sum or shasum is required to verify the TermKeys release."
fi

TMP_DIR="$(mktemp -d "${TMPDIR:-/tmp}/termkeys-install.XXXXXX")" || fail "Could not create a temporary directory."
RELEASE_JSON="$TMP_DIR/releases.json"

log "Checking GitHub Releases for the newest Linux x86_64 package..."
curl -fsSL \
    -H 'Accept: application/vnd.github+json' \
    -H 'X-GitHub-Api-Version: 2022-11-28' \
    "$RELEASES_API" \
    -o "$RELEASE_JSON" \
    || fail "Could not read TermKeys release metadata from GitHub."

ARCHIVE_URL="$(
    sed -n 's/.*"browser_download_url": "\([^"]*\/TermKeys-v[^"]*-linux-x86_64\.tar\.gz\)".*/\1/p' "$RELEASE_JSON" \
        | head -n 1
)"

[ -n "$ARCHIVE_URL" ] || fail "No published TermKeys Linux x86_64 release asset was found."

ARCHIVE_NAME="${ARCHIVE_URL##*/}"
DOWNLOAD_SUFFIX="${ARCHIVE_URL#*'/releases/download/'}"
TAG_NAME="${DOWNLOAD_SUFFIX%%/*}"

[ -n "$TAG_NAME" ] && [ "$TAG_NAME" != "$ARCHIVE_URL" ] || fail "Could not determine the release tag from GitHub metadata."

CHECKSUM_URL="https://github.com/${REPOSITORY}/releases/download/${TAG_NAME}/SHA256SUMS.txt"
ARCHIVE_PATH="$TMP_DIR/$ARCHIVE_NAME"
CHECKSUM_PATH="$TMP_DIR/SHA256SUMS.txt"
EXTRACT_DIR="$TMP_DIR/extracted"

log "Selected release $TAG_NAME."
log "Downloading $ARCHIVE_NAME..."
curl -fsSL "$ARCHIVE_URL" -o "$ARCHIVE_PATH" || fail "Could not download $ARCHIVE_NAME."

log "Downloading SHA256SUMS.txt..."
curl -fsSL "$CHECKSUM_URL" -o "$CHECKSUM_PATH" || fail "Could not download SHA256SUMS.txt for $TAG_NAME."

EXPECTED_HASH="$(
    awk -v name="$ARCHIVE_NAME" '
        $2 == name || $2 == ("*" name) || $2 == ("./" name) { print $1; exit }
    ' "$CHECKSUM_PATH"
)"

printf '%s\n' "$EXPECTED_HASH" | grep -Eq '^[0-9A-Fa-f]{64}$' \
    || fail "SHA256SUMS.txt does not contain a valid checksum for $ARCHIVE_NAME."

if [ "$SHA256_COMMAND" = "sha256sum" ]; then
    ACTUAL_HASH="$(sha256sum "$ARCHIVE_PATH" | awk '{print $1}')"
else
    ACTUAL_HASH="$(shasum -a 256 "$ARCHIVE_PATH" | awk '{print $1}')"
fi

if [ "$ACTUAL_HASH" != "$EXPECTED_HASH" ]; then
    fail "Checksum verification failed. Nothing was installed."
fi

log "SHA-256 checksum verified."

ARCHIVE_LIST="$TMP_DIR/archive-list.txt"
tar -tzf "$ARCHIVE_PATH" > "$ARCHIVE_LIST" || fail "The verified release archive could not be read."

if grep -Eq '(^/|(^|/)\.\.(/|$))' "$ARCHIVE_LIST"; then
    fail "The release archive contains an unsafe path. Nothing was extracted."
fi

mkdir -p "$EXTRACT_DIR"
tar -xzf "$ARCHIVE_PATH" -C "$EXTRACT_DIR" || fail "Could not extract the verified TermKeys release archive."

BINARY_CANDIDATES="$(find "$EXTRACT_DIR" -type f -name 'termkeys' -print)"
BINARY_COUNT="$(printf '%s\n' "$BINARY_CANDIDATES" | awk 'NF { count++ } END { print count + 0 }')"

[ "$BINARY_COUNT" -eq 1 ] || fail "Expected exactly one 'termkeys' binary in the verified release archive; found $BINARY_COUNT."

BINARY_PATH="$BINARY_CANDIDATES"
mkdir -p "$INSTALL_DIR" || fail "Could not create $INSTALL_DIR."

STAGED_PATH="${INSTALL_PATH}.tmp.$$"
cp "$BINARY_PATH" "$STAGED_PATH" || fail "Could not stage the TermKeys binary for installation."
chmod 0755 "$STAGED_PATH" || fail "Could not set executable permissions on the staged binary."
mv -f "$STAGED_PATH" "$INSTALL_PATH" || fail "Could not install TermKeys to $INSTALL_PATH."
STAGED_PATH=""

log "Installed TermKeys to $INSTALL_PATH."

case ":${PATH:-}:" in
    *":$INSTALL_DIR:"*)
        ;;
    *)
        log "$INSTALL_DIR is not currently in PATH."
        log "Add it to your shell configuration, for example:"
        log "  export PATH=\"\$HOME/.local/bin:\$PATH\""
        ;;
esac

log "Installation complete. The installer did not use sudo and did not modify TermKeys configuration or backups."
