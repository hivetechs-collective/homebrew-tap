cask "hive-consensus-beta" do
  version "1.8.692"
  sha256 "0b24f024083e2c42ce6929863a1da85691d1e6ef7b8c98709dbcf14eb0565c23"

  url "https://github.com/hivetechs-collective/homebrew-tap/releases/download/v#{version}-beta/Hive-Consensus-#{version}.dmg"
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
    - Service status monitoring for Cloudflare/OpenRouter outages

    To report issues or provide feedback:
    https://github.com/hivetechs-collective/homebrew-tap/issues

    To switch back to stable:
      brew uninstall --cask hive-consensus-beta
      brew install --cask hive-consensus
  EOS
end
