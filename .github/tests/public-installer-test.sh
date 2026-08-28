#!/bin/sh

set -eu

ROOT_DIR="$(CDPATH='' cd "$(dirname "$0")/../.." && pwd)"
TMP_ROOT="$(mktemp -d "${TMPDIR:-/tmp}/termkeys-public-test.XXXXXX")"

cleanup() {
    rm -rf "$TMP_ROOT"
}

trap cleanup EXIT HUP INT TERM

fail() {
    printf '%s\n' "TEST ERROR: $*" >&2
    exit 1
}

TEST_HOME="$TMP_ROOT/home"
mkdir -p "$TEST_HOME/.local/bin" "$TEST_HOME/.config/termkeys" "$TEST_HOME/.local/share/termkeys/backups"

printf '%s\n' "keep-config" > "$TEST_HOME/.config/termkeys/example.conf"
printf '%s\n' "keep-backup" > "$TEST_HOME/.local/share/termkeys/backups/example.bak"

DRY_RUN_OUTPUT="$(HOME="$TEST_HOME" sh "$ROOT_DIR/scripts/install.sh" --dry-run)"
printf '%s\n' "$DRY_RUN_OUTPUT" | grep -q 'no files were downloaded or changed' \
    || fail "Installer dry run did not confirm that it made no changes."

[ ! -e "$TEST_HOME/.local/bin/termkeys" ] || fail "Installer dry run created a TermKeys binary."

printf '%s\n' '#!/bin/sh' > "$TEST_HOME/.local/bin/termkeys"
printf '%s\n' 'exit 0' >> "$TEST_HOME/.local/bin/termkeys"
chmod 0755 "$TEST_HOME/.local/bin/termkeys"

HOME="$TEST_HOME" sh "$ROOT_DIR/scripts/uninstall.sh" >/dev/null

[ ! -e "$TEST_HOME/.local/bin/termkeys" ] || fail "Uninstaller did not remove the expected binary."
[ -f "$TEST_HOME/.config/termkeys/example.conf" ] || fail "Uninstaller removed user configuration."
[ -f "$TEST_HOME/.local/share/termkeys/backups/example.bak" ] || fail "Uninstaller removed user backups."

HOME="$TEST_HOME" sh "$ROOT_DIR/scripts/uninstall.sh" >/dev/null

printf '%s\n' "Public installer/uninstaller safety tests passed."
