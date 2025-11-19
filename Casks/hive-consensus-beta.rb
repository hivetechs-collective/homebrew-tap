cask "hive-consensus-beta" do
  version "1.8.695"
  sha256 "30433e2424356ee39b52abeb131baf7bc5238f51fd35989ab61b38713cdc65e8"

  url "https://github.com/hivetechs-collective/homebrew-tap/releases/download/v#{version}-beta/Hive-Consensus-#{version}-beta.dmg"
  name "Hive Consensus Beta"
  desc "AI development environment with integrated terminals (Beta Testing)"
  homepage "https://github.com/hivetechs-collective/homebrew-tap"

  # Beta releases don't use livecheck
  livecheck do
    skip "Beta releases require manual updates"
  end

  # Conflicts with stable version - uninstall stable before installing beta
  conflicts_with cask: "hive-consensus"
  depends_on macos: ">= :big_sur"

  app "Hive Consensus.app"

  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Hive Consensus.app"],
                   sudo: false
  end

  zap trash: [
    "~/Library/Application Support/Hive Consensus",
    "~/Library/Logs/Hive Consensus",
    "~/Library/Preferences/com.hivetechs.hive-consensus.plist",
    "~/Library/Saved Application State/com.hivetechs.hive-consensus.savedState",
  ]

  caveats <<~EOS
    🧪 This is a BETA release for testing new features.

    Features in this beta:
    - Updated What's New panel with detailed v1.8.692 release notes
    - Beta indicators in both About dialogs (native macOS + Help > About)
    - Improved beta messaging and detection

    Testing checklist:
    - Help > What's New - Shows detailed release notes
    - Hive Consensus > About - Shows "Version: 1.8.693 (Beta)"
    - Help > About - Shows "🧪 Beta Release" indicator

    To report issues or provide feedback:
    https://github.com/hivetechs-collective/homebrew-tap/issues

    To switch back to stable:
      brew uninstall --cask hive-consensus-beta
      brew install --cask hive-consensus
  EOS
end
