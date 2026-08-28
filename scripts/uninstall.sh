#!/bin/sh

set -eu

fail() {
    printf '%s\n' "[TermKeys] ERROR: $*" >&2
    exit 1
}

[ -n "${HOME:-}" ] || fail "HOME is not set; cannot determine ~/.local/bin."

INSTALL_PATH="$HOME/.local/bin/termkeys"

printf '%s\n' "[TermKeys] This uninstaller only removes: $INSTALL_PATH"
printf '%s\n' "[TermKeys] It does not remove TermKeys configuration, backups, shell/editor settings, or other user data."

if [ -d "$INSTALL_PATH" ]; then
    fail "$INSTALL_PATH is a directory, not the expected TermKeys binary; refusing to remove it."
fi

if [ -e "$INSTALL_PATH" ] || [ -L "$INSTALL_PATH" ]; then
    rm -f "$INSTALL_PATH" || fail "Could not remove $INSTALL_PATH."
    printf '%s\n' "[TermKeys] Removed $INSTALL_PATH."
else
    printf '%s\n' "[TermKeys] No TermKeys binary was found at $INSTALL_PATH. Nothing to remove."
fi

printf '%s\n' "[TermKeys] User configuration and backups were left untouched."
