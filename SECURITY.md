# Security Policy

## Supported Version

TermKeys is currently in alpha.

| Version | Supported |
|---|---|
| 0.1.x | Yes |

## Reporting a Vulnerability

Please do not report suspected security vulnerabilities through a public GitHub issue.

Use the official BLCCoreStudio project channels to contact the maintainer privately.

When reporting a vulnerability, include only the minimum information required to reproduce the issue.

Do not include:

- passwords
- API keys
- access tokens
- private keys
- SSH keys
- confidential configuration
- private repository contents
- personal data

## Security Scope

TermKeys modifies local shell and editor configuration files.

Security-sensitive behavior includes:

- configuration backup handling
- restore operations
- conflict detection
- managed configuration ownership checks
- file permission preservation
- installation and uninstall behavior

TermKeys is designed to refuse unsafe configuration changes when ownership or restore safety cannot be established.

## Malicious Contributions

Pull requests or issue content containing malware, credential theft, backdoors, destructive behavior, unauthorized telemetry, or supply-chain attacks will be rejected.

## Release Verification

Official release archives are accompanied by SHA-256 checksums.

Users should verify downloaded artifacts before use:

```bash
sha256sum -c SHA256SUMS.txt
