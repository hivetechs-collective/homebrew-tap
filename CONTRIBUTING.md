# Contributing to Hive Consensus Homebrew Tap

Thank you for your interest in contributing to the Hive Consensus Homebrew tap!

## Repository Purpose

This repository contains Homebrew cask formulas for installing Hive Consensus on macOS. It supports two release channels:

- **Stable**: `hive-consensus` - Production-ready releases
- **Beta**: `hive-consensus-beta` - Early access to new features

## Cask Maintenance

### Stable Releases

Stable releases are updated via automated pipeline when a new version is released:

1. Release pipeline builds and signs DMG
2. DMG uploaded to GitHub Releases with tag `vX.Y.Z`
3. Cask automatically updated with new version and SHA256
4. Changes committed and pushed to `main` branch

**Manual updates** (if automation fails):

```bash
# Update version
sed -i '' 's/version ".*"/version "X.Y.Z"/' Casks/hive-consensus.rb

# Compute SHA256
shasum -a 256 Hive-Consensus-X.Y.Z.dmg

# Update SHA256
sed -i '' 's/sha256 ".*"/sha256 "NEW_SHA256"/' Casks/hive-consensus.rb

# Verify cask
brew audit --cask hive-consensus
brew style --fix Casks/hive-consensus.rb

# Commit and push
git add Casks/hive-consensus.rb
git commit -m "chore(cask): update hive-consensus to vX.Y.Z"
git push origin main
```

### Beta Releases

Beta releases follow a similar process but with different versioning:

**Version Format**: `X.Y.Z` (same as stable, but released more frequently)

**Git Tag Format**: `vX.Y.Z-beta` (distinguishes beta from stable releases)

**When to Create Beta Releases**:

- New feature completed and tested locally
- Feature passes all quality gates (build, signing, notarization)
- Feature ready for community testing
- Breaking changes or significant UI changes (get feedback early)

**Beta Release Process**:

```bash
# 1. Build and sign beta DMG (automated via release pipeline)
./scripts/release.sh X.Y.Z beta

# 2. Upload to GitHub Releases with tag vX.Y.Z-beta
gh release create "vX.Y.Z-beta" Hive-Consensus-X.Y.Z.dmg \
  --title "vX.Y.Z Beta" \
  --notes "Beta release for testing new features" \
  --prerelease

# 3. Update beta cask
cd homebrew-tap
sed -i '' 's/version ".*"/version "X.Y.Z"/' Casks/hive-consensus-beta.rb

# 4. Compute SHA256 from signed DMG
shasum -a 256 Hive-Consensus-X.Y.Z.dmg

# 5. Update SHA256 and caveats
sed -i '' 's/sha256 ".*"/sha256 "NEW_SHA256"/' Casks/hive-consensus-beta.rb

# Edit caveats to describe new features being tested
vim Casks/hive-consensus-beta.rb

# 6. Verify cask
brew audit --cask hive-consensus-beta
brew style --fix Casks/hive-consensus-beta.rb

# 7. Commit and push
git add Casks/hive-consensus-beta.rb
git commit -m "chore(cask): update hive-consensus-beta to vX.Y.Z

Features in this beta:
- Feature 1 description
- Feature 2 description"
git push origin main
```

### Testing Requirements

**Before releasing to stable**:

1. Beta version tested by at least 3 users
2. No critical bugs reported in 48 hours
3. All features documented
4. Performance benchmarks meet targets

**Before releasing to beta**:

1. Passes all automated quality gates (Gate 0-7)
2. Manually tested on clean macOS installation
3. Gatekeeper assessment passes
4. App launches without errors

## Versioning Strategy

### Stable Versioning

- **Major version** (X.0.0): Breaking changes, major features
- **Minor version** (1.Y.0): New features, enhancements
- **Patch version** (1.8.Z): Bug fixes, minor improvements

Example progression:
```
1.8.689 (stable) → 1.8.690 (stable) → 1.8.691 (stable)
```

### Beta Versioning

Beta versions use the **same version number** as they will have when promoted to stable:

```
1.8.691 (stable) ← current stable
1.8.692 (beta)   ← testing new feature
1.8.693 (beta)   ← testing another feature
1.8.692 (stable) ← promoted after successful beta testing
1.8.693 (stable) ← promoted after successful beta testing
```

**Key Principles**:

- Beta versions are always ahead of stable
- Multiple beta releases can exist before promotion
- Beta version becomes stable version when promoted (no renumbering)
- Tag format distinguishes: `v1.8.692-beta` vs `v1.8.692`

## Cask Structure

### Required Fields

```ruby
cask "hive-consensus" do
  version "X.Y.Z"                    # Semantic version
  sha256 "abc123..."                 # SHA256 of DMG (MUST match exactly)

  url "https://github.com/..."       # GitHub Releases URL
  name "Hive Consensus"              # Display name
  desc "AI development environment"  # Short description
  homepage "https://github.com/..."  # Project homepage

  livecheck do ... end               # Auto-update detection (stable only)
  depends_on macos: ">= :big_sur"    # Minimum macOS version
  conflicts_with cask: "..."         # Conflicts (beta only)

  app "Hive Consensus.app"           # App to install

  postflight do ... end              # Quarantine removal
  zap trash: [ ... ]                 # Cleanup paths
  caveats <<~EOS ... EOS             # User warnings (beta only)
end
```

### Stable vs Beta Differences

**Stable cask** (`hive-consensus.rb`):
- Uses `livecheck` for automatic updates
- No `conflicts_with` directive
- No `caveats` message
- Git tag: `vX.Y.Z`
- URL: `.../releases/download/vX.Y.Z/...`

**Beta cask** (`hive-consensus-beta.rb`):
- Disables `livecheck` (manual updates only)
- Includes `conflicts_with cask: "hive-consensus"`
- Includes `caveats` describing beta features
- Git tag: `vX.Y.Z-beta`
- URL: `.../releases/download/vX.Y.Z-beta/...`

## SHA256 Computation

**CRITICAL**: SHA256 must be computed AFTER all DMG modifications:

```bash
# Correct sequence:
1. Build app bundle
2. Sign all binaries (deep signing)
3. Create DMG from signed app
4. Sign DMG itself
5. Notarize DMG
6. Staple notarization ticket to DMG
7. NOW compute SHA256 ← THIS is the final checksum

# Compute SHA256
shasum -a 256 Hive-Consensus-X.Y.Z.dmg
```

**Common mistake**: Computing SHA256 before stapling causes mismatches.

## Pull Request Guidelines

### For Cask Updates

```markdown
**Type**: Cask Update
**Channel**: Stable / Beta
**Version**: X.Y.Z

**Checklist**:
- [ ] Version number updated
- [ ] SHA256 matches signed DMG
- [ ] URL points to correct GitHub Release
- [ ] `brew audit --cask` passes
- [ ] `brew style` passes
- [ ] Tested installation locally
- [ ] Gatekeeper assessment passes

**Testing**:
```bash
brew uninstall --cask hive-consensus  # or hive-consensus-beta
brew install --cask ./Casks/hive-consensus.rb
open -a "Hive Consensus"
spctl --assess --verbose "/Applications/Hive Consensus.app"
```
```

### For Documentation Updates

```markdown
**Type**: Documentation
**Files**: README.md / CONTRIBUTING.md

**Summary**: Brief description of changes

**Checklist**:
- [ ] Markdown linting passes
- [ ] Links tested
- [ ] Code examples verified
```

## Quality Standards

### Homebrew Compliance

All casks must pass:

```bash
# Audit cask for issues
brew audit --cask hive-consensus
brew audit --cask hive-consensus-beta

# Check style compliance
brew style Casks/hive-consensus.rb
brew style Casks/hive-consensus-beta.rb

# Auto-fix style issues
brew style --fix Casks/hive-consensus.rb
brew style --fix Casks/hive-consensus-beta.rb
```

### Installation Testing

Before pushing updates, verify installation:

```bash
# Test stable cask
brew uninstall --cask hive-consensus 2>/dev/null || true
brew install --cask ./Casks/hive-consensus.rb
open -a "Hive Consensus"

# Verify signature
codesign --verify --deep --strict "/Applications/Hive Consensus.app"
spctl --assess --type exec --verbose "/Applications/Hive Consensus.app"

# Test beta cask
brew uninstall --cask hive-consensus 2>/dev/null || true
brew install --cask ./Casks/hive-consensus-beta.rb
open -a "Hive Consensus"

# Verify signature
codesign --verify --deep --strict "/Applications/Hive Consensus.app"
spctl --assess --type exec --verbose "/Applications/Hive Consensus.app"
```

## Common Issues

### SHA256 Mismatch

**Symptom**: Homebrew reports SHA256 doesn't match during installation

**Cause**: SHA256 computed before DMG stapling, or DMG modified after computation

**Fix**:
1. Re-download the DMG from GitHub Releases
2. Compute SHA256 from downloaded DMG (not local build)
3. Verify DMG is stapled: `xcrun stapler validate Hive-Consensus-X.Y.Z.dmg`
4. Update cask with new SHA256

### Gatekeeper Rejection

**Symptom**: macOS prevents app from opening ("app is damaged")

**Cause**: DMG not properly signed or notarized

**Fix**:
1. Verify DMG signature: `codesign --verify Hive-Consensus-X.Y.Z.dmg`
2. Verify notarization: `xcrun stapler validate Hive-Consensus-X.Y.Z.dmg`
3. If either fails, re-release with proper signing/notarization
4. Do NOT ship unsigned builds to beta users

### Version Conflicts

**Symptom**: Cannot install beta while stable is installed

**Expected**: This is correct behavior due to `conflicts_with` directive

**Solution**: User must uninstall stable before installing beta (documented in README)

## Release Checklist

### Stable Release

- [ ] All quality gates passed (Gate 0-7)
- [ ] GitHub Release created with tag `vX.Y.Z`
- [ ] DMG uploaded to GitHub Release
- [ ] SHA256 computed from released DMG
- [ ] Cask updated with version and SHA256
- [ ] `brew audit --cask hive-consensus` passes
- [ ] Installation tested on clean macOS
- [ ] Git commit created with semantic message
- [ ] Changes pushed to `origin/main`

### Beta Release

- [ ] Feature complete and locally tested
- [ ] All quality gates passed (Gate 0-7)
- [ ] GitHub Release created with tag `vX.Y.Z-beta` and `--prerelease` flag
- [ ] DMG uploaded to GitHub Release
- [ ] SHA256 computed from released DMG
- [ ] Cask updated with version, SHA256, and caveats describing new features
- [ ] `brew audit --cask hive-consensus-beta` passes
- [ ] Installation tested on clean macOS
- [ ] Git commit created describing beta features
- [ ] Changes pushed to `origin/main`
- [ ] Issue created for beta testing feedback

## Contact

- **Homebrew tap issues**: https://github.com/hivetechs-collective/homebrew-tap/issues
- **Product support**: support@hivetechs.io
- **Product development**: https://github.com/hivetechs-collective/Hive

## License

This repository (cask formulas and scripts) is open source under MIT License. See [LICENSE](LICENSE) for details.

The Hive Consensus application itself is proprietary software. See https://hivetechs.io/terms for software license terms.
