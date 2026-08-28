<div align="center">

# TermKeys

### Safer, faster terminal shortcuts by BLCCoreStudio

[![Version](https://img.shields.io/badge/version-0.1.0-059669?style=for-the-badge)](https://github.com/BLCCoreStudio/TermKeys/releases/tag/v0.1.0)
![Status](https://img.shields.io/badge/status-alpha%20%2F%20pre--release-0F766E?style=for-the-badge)
![Platform](https://img.shields.io/badge/platform-Linux%20x86__64-111827?style=for-the-badge&logo=linux&logoColor=white)
[![License](https://img.shields.io/badge/license-proprietary-334155?style=for-the-badge)](LICENSE)

**A Linux terminal shortcut manager for Fish shell and GNU Nano with automatic backups, conflict detection, and safe restore.**

[Download v0.1.0](https://github.com/BLCCoreStudio/TermKeys/releases/tag/v0.1.0) · [Security](SECURITY.md) · [Changelog](CHANGELOG.md) · [Contributing](CONTRIBUTING.md)

</div>

---

TermKeys is a lightweight Linux CLI tool for managing useful terminal keyboard shortcuts and key bindings without hand-editing shell or editor configuration files. The current alpha release supports Fish shell and GNU Nano, with configuration backups, conflict detection, safe writes, diagnostics, uninstall, and restore workflows built around local configuration safety.

## Why TermKeys

- Add useful terminal shortcuts without manually editing shell or editor configuration files
- Fish shell and GNU Nano integration in the current release
- Automatic original-configuration backups before managed changes
- Existing shortcut conflict detection to avoid silently replacing a key binding
- Safe uninstall and original-configuration restore
- Status inspection and `doctor` diagnostics for managed configuration
- No sudo requirement, telemetry, intentional network communication, or credential storage in `0.1.0`

## Quick Start

TermKeys `v0.1.0` is an **alpha / pre-release** for Linux x86_64.

### 1. Download

Download both files from the official release:

- [`TermKeys-v0.1.0-linux-x86_64.tar.gz`](https://github.com/BLCCoreStudio/TermKeys/releases/download/v0.1.0/TermKeys-v0.1.0-linux-x86_64.tar.gz)
- [`SHA256SUMS.txt`](https://github.com/BLCCoreStudio/TermKeys/releases/download/v0.1.0/SHA256SUMS.txt)

Release page: [TermKeys v0.1.0](https://github.com/BLCCoreStudio/TermKeys/releases/tag/v0.1.0)

### 2. Verify

```bash
sha256sum -c SHA256SUMS.txt
```

### 3. Extract

```bash
tar -xzf TermKeys-v0.1.0-linux-x86_64.tar.gz
cd TermKeys-v0.1.0-linux-x86_64
```

The public repository does not document an unverified executable invocation. Use only commands documented by the release package or the program's own help output after extraction.

## What the Current Shortcut Does

TermKeys `0.1.0` currently manages an F12 shortcut while providing the backup, conflict-detection, ownership, diagnostics, uninstall, and restore workflow around that change.

### Fish shell

Pressing `F12`:

- clears the current command line
- clears the terminal screen

### GNU Nano

Pressing `F12` clears the current buffer using Nano's cut-buffer behavior.

The product is not intended to be only an F12 script: its core value is safer local shortcut and shell/editor configuration management around managed key bindings.

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
- Safe restore workflow
- Managed configuration ownership checks
- Atomic configuration writes
- Existing file permission preservation
- Restore path validation
- `status` command
- `doctor` command
- `plan` command
- SHA-256 release verification

## Safety Model

TermKeys modifies local shell and editor configuration files, so configuration safety is treated as a core product concern.

Security-sensitive behavior includes:

- automatic configuration backups
- restore operations and restore path validation
- existing shortcut conflict detection
- managed configuration ownership checks
- atomic configuration writes
- existing file permission preservation
- installation and uninstall behavior

TermKeys is designed to refuse unsafe configuration changes when ownership or restore safety cannot be established.

Additional release security properties for `0.1.0`:

- No sudo requirement
- No telemetry
- No intentional network communication
- No credential storage
- Refuses unsafe configuration overwrites
- Official release archive accompanied by SHA-256 verification data

See [SECURITY.md](SECURITY.md) for vulnerability reporting and security scope.

## Platform Support

| Platform | Status |
| --- | --- |
| Linux x86_64 | Official `0.1.0` pre-release · verified on Debian 11 / glibc 2.31 |
| Windows | Not currently officially supported |
| macOS | Not currently officially supported |

## Public Repository Model

TermKeys uses a proprietary binary distribution model. The complete implementation is maintained privately by BLCCoreStudio.

This public repository is the official location for intentionally published TermKeys material, including:

- official releases and release information
- documentation and changelog history
- security information and vulnerability-reporting guidance
- contribution resources
- issue, compatibility, and usability feedback

Private development areas include:

- application source code
- configuration management implementation
- backup and restore implementation
- conflict detection logic
- internal tests
- build tooling
- release engineering
- proprietary product logic

Public visibility of this repository does not make the complete TermKeys implementation open source.

The public repository validation workflow checks required public files, enforces the tracked-file whitelist, rejects sensitive file types, and blocks designated private implementation paths.

## Contributing

Community contributions may include documentation improvements, typo and wording fixes, English and Turkish translations, usage examples, compatibility reports, bug reports, feature requests, and usability suggestions.

Read [CONTRIBUTING.md](CONTRIBUTING.md) before opening a pull request.

Do not report suspected security vulnerabilities through public issues; follow [SECURITY.md](SECURITY.md).

## Release History

See [CHANGELOG.md](CHANGELOG.md).

## Rights and Licensing

TermKeys is proprietary software developed and maintained by BLCCoreStudio.

Permission to use officially published release binaries is governed by the repository [LICENSE](LICENSE). Public visibility of selected repository files does not make the complete implementation open source.

---

<div align="center">

**Built by BLCCoreStudio.**

[Release](https://github.com/BLCCoreStudio/TermKeys/releases/tag/v0.1.0) · [Security](SECURITY.md) · [Changelog](CHANGELOG.md) · [License](LICENSE)

</div>
