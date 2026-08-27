<div align="center">

# TermKeys

### Safer, faster terminal shortcuts by BLCCoreStudio

[![Version](https://img.shields.io/badge/version-0.1.0-059669?style=for-the-badge)](https://github.com/BLCCoreStudio/TermKeys/releases/tag/v0.1.0)
![Status](https://img.shields.io/badge/status-alpha%20%2F%20pre--release-0F766E?style=for-the-badge)
![Platform](https://img.shields.io/badge/platform-Linux%20x86__64-111827?style=for-the-badge&logo=linux&logoColor=white)
[![License](https://img.shields.io/badge/license-proprietary-334155?style=for-the-badge)](LICENSE)

**Useful keyboard shortcuts without hand-editing shell and editor configuration files.**

[Release v0.1.0](https://github.com/BLCCoreStudio/TermKeys/releases/tag/v0.1.0) · [Security](SECURITY.md) · [Changelog](CHANGELOG.md) · [Contributing](CONTRIBUTING.md)

</div>

---

TermKeys is a lightweight Linux utility for installing useful keyboard shortcuts without manually editing shell and editor configuration files.

## Current Version

**Version:** `0.1.0`  
**Status:** Alpha / Pre-release  
**Platform:** Linux x86_64

> [!IMPORTANT]
> TermKeys uses a proprietary binary distribution model. The complete implementation is maintained privately by BLCCoreStudio; this public repository contains intentionally published documentation, contribution resources, release information, and related public material.

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

The current release also includes:

- Safe restore workflow
- Managed configuration ownership checks
- Atomic configuration writes
- Existing file permission preservation
- Restore path validation
- `status` command
- `doctor` command
- `plan` command
- SHA-256 release verification

## F12 Behavior

### Fish

Pressing `F12`:

- clears the current command line
- clears the terminal screen

### GNU Nano

Pressing `F12` clears the current buffer using Nano's cut-buffer behavior.

## Safety Model

TermKeys modifies local shell and editor configuration files, so configuration safety is treated as a core product concern.

Security-sensitive behavior includes:

- configuration backup handling
- restore operations
- conflict detection
- managed configuration ownership checks
- file permission preservation
- installation and uninstall behavior

TermKeys is designed to refuse unsafe configuration changes when ownership or restore safety cannot be established.

Additional release security properties for `0.1.0`:

- No sudo requirement
- No telemetry
- No intentional network communication
- No credential storage
- Refuses unsafe configuration overwrites

See [SECURITY.md](SECURITY.md) for vulnerability reporting and security scope.

## Download & Installation

Download the official `v0.1.0` release from GitHub:

- [`TermKeys-v0.1.0-linux-x86_64.tar.gz`](https://github.com/BLCCoreStudio/TermKeys/releases/download/v0.1.0/TermKeys-v0.1.0-linux-x86_64.tar.gz)
- [`SHA256SUMS.txt`](https://github.com/BLCCoreStudio/TermKeys/releases/download/v0.1.0/SHA256SUMS.txt)

Release page: [TermKeys v0.1.0](https://github.com/BLCCoreStudio/TermKeys/releases/tag/v0.1.0)

Extract:

```bash
tar -xzf TermKeys-v0.1.0-linux-x86_64.tar.gz
cd TermKeys-v0.1.0-linux-x86_64
```

## Release Verification

Official release archives are accompanied by SHA-256 checksums.

Verify downloaded artifacts before use:

```bash
sha256sum -c SHA256SUMS.txt
```

## Platform Support

| Platform | Status |
| --- | --- |
| Linux x86_64 | Official `0.1.0` release · verified on Debian 11 / glibc 2.31 |
| Windows | Not currently officially supported |
| macOS | Not currently officially supported |

## Public Repository Model

TermKeys uses a split development model:

- the complete implementation is proprietary and maintained privately by BLCCoreStudio
- this public repository contains documentation, contribution resources, release information, and other intentionally published material

Private development areas include:

- application source code
- configuration management implementation
- backup and restore implementation
- conflict detection logic
- internal tests
- build tooling
- release engineering
- proprietary product logic

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
