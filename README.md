# Homebrew Tap for Hive Consensus

Official Homebrew tap for [Hive Consensus](https://github.com/hivetechs-collective/Hive) - AI-powered development environment.

## Installation

### Stable Release (Recommended)

```bash
# One-line installation
brew install --cask hivetechs-collective/tap/hive-consensus
```

### Beta Release (Testing New Features)

```bash
# Install beta channel for early access to new features
brew install --cask hivetechs-collective/tap/hive-consensus-beta
```

**Note**: Beta releases may contain bugs and are updated more frequently than stable releases. Cannot be installed alongside the stable version.

## Switching Between Stable and Beta

### Switch from Stable to Beta

```bash
brew uninstall --cask hive-consensus
brew install --cask hive-consensus-beta
```

### Switch from Beta to Stable

```bash
brew uninstall --cask hive-consensus-beta
brew install --cask hive-consensus
```

## Update

```bash
# Update stable release
brew upgrade --cask hive-consensus

# Update beta release
brew upgrade --cask hive-consensus-beta
```

## Uninstall

```bash
# Uninstall stable release
brew uninstall --cask hive-consensus

# Uninstall beta release
brew uninstall --cask hive-consensus-beta
```

## Features

- **Signed & Notarized** by Apple (Developer ID Application)
- **Gatekeeper‑friendly** installs via Homebrew Cask (no xattr workarounds)
- **Verified downloads** (SHA256) through Homebrew
- **Easy updates** with `brew upgrade --cask hive-consensus`
- **Apple Silicon (arm64)** support on macOS 11+

## Requirements

- macOS 11.0 or later
- Homebrew 4.0 or later

## Beta Channel

The beta channel provides early access to new features before they reach stable release:

- **More frequent updates**: New features released as they're completed
- **Early access**: Test cutting-edge features before general availability
- **Community testing**: Help improve Hive Consensus by reporting issues
- **Same quality**: All beta releases are signed, notarized, and pass quality gates

**How to verify you're running beta**:
- Check **Hive Consensus > About Hive Consensus** (menu bar)
- Check **Help > About** (in-app menu)
- Both will show: `Version: 1.8.692 (Beta)` with 🧪 indicator

**Current beta version**: Check [Releases](https://github.com/hivetechs-collective/homebrew-tap/releases) for latest beta

**Feedback**: Report issues or suggestions at https://github.com/hivetechs-collective/homebrew-tap/issues

**Note**: Beta releases are production-ready but may contain new features still being refined based on user feedback.

## License

**Homebrew Tap (This Repository)**: MIT License
- This repository (cask formulas and scripts) is open source under MIT License
- See [LICENSE](LICENSE) for details

**Hive Consensus Software**: Proprietary License
- The application installed by this tap is proprietary software
- Requires active subscription for use
- See https://hivetechs.io/terms for software license terms

## International Availability

Hive Consensus is available globally with full compliance for:
- 🇪🇺 European Union (GDPR compliant)
- 🇬🇧 United Kingdom (UK GDPR compliant)
- 🇺🇸 United States (CCPA/Florida law compliant)
- 🇨🇦 Canada (PIPEDA compliant)
- 🇦🇺 Australia (ACL compliant)
- 🇧🇷 Brazil (LGPD compliant)
- And 172+ countries via international arbitration enforcement

**Trial Period**: 14-day free trial (no credit card required)

---

## Legal & Privacy

**Terms & Policies**:
- [Terms of Service](https://hivetechs.io/terms) - Complete terms for all users
- [Software License](https://hivetechs.io/software-license) - Proprietary license agreement
- [Privacy Policy](https://hivetechs.io/privacy) - GDPR compliant privacy
- [Refund Policy](https://hivetechs.io/refund) - International refund rights

**Data Protection**:
- GDPR compliant (EU users)
- UK GDPR compliant (UK users)
- CCPA compliant (California users)
- Privacy contact: privacy@hivetechs.io

---

## Troubleshooting

### Duplicate Tap Error

If you see: `Error: Cask hive-consensus exists in multiple taps`, you have the tap registered under two names.

**Fix**:
```bash
# 1. Uninstall using the fully-qualified name
brew uninstall --cask hivetechs-collective/tap/hive-consensus

# 2. Remove the duplicate tap
brew untap hivetechs-collective/tap

# 3. Reinstall using the correct short name
brew install --cask hivetechs/tap/hive-consensus-beta
```

The correct tap name is `hivetechs/tap` (short form).

---

## Support

- **Homebrew tap issues**: https://github.com/hivetechs-collective/homebrew-tap/issues
- **Product support**: support@hivetechs.io
- **Product questions**: https://github.com/hivetechs-collective/hive-consensus-support
- **Website**: https://hivetechs.io
