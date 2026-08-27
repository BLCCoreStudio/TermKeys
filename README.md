# TermKeys

**Safer, faster terminal shortcuts by BLCCoreStudio.**

TermKeys is a lightweight Linux utility for installing useful keyboard shortcuts without manually editing shell and editor configuration files.

## Current Version

**Version:** `0.1.0`

**Status:** Alpha / Pre-release

**Platform:** Linux x86_64

## Features

TermKeys v0.1.0 currently provides:

- Fish shell integration
- GNU Nano integration
- F12 quick-clear shortcut
- Automatic configuration backups
- Existing shortcut conflict detection
- Safe configuration writes
- Status inspection
- Doctor diagnostics
- Safe uninstall
- Original configuration restore

### Fish

Pressing `F12`:

- clears the current command line
- clears the terminal screen

### GNU Nano

Pressing `F12` clears the current buffer using Nano's cut-buffer behavior.

## Download & Installation

Download these files from the GitHub Releases page:

- `TermKeys-v0.1.0-linux-x86_64.tar.gz`
- `SHA256SUMS.txt`

Extract:

```bash
tar -xzf TermKeys-v0.1.0-linux-x86_64.tar.gz
cd TermKeys-v0.1.0-linux-x86_64
