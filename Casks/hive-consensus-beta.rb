cask "hive-consensus-beta" do
  version "1.8.766"
  sha256 "fd451c76dfd768858d720703901fbbc7d18644029bc9b961e381759b0f5bb06e"

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
    🧪 BETA RELEASE - Progressive Onboarding (v1.8.757)

    You're using the beta channel for Hive Consensus. This version includes:
    - NEW: Non-blocking progressive onboarding banner (replaces wizard)
    - NEW: Simplified setup - only 2 fields (name + directory)
    - NEW: IDE tour is now opt-in via Help menu
    - FIX: Resolved crash loop issues from blocking startup UIs
    - Enhanced HiveTechs CLI with 342+ AI models

    All beta releases pass the same 9 quality gates as stable releases.

    HiveTechs CLI (Animated Bee Icon):
    - Access 342+ AI models via OpenRouter
    - Real-time cost tracking and streaming responses
    - Type /help for all commands
    - Type /models to switch models anytime

    To report issues or provide feedback:
    https://github.com/hivetechs-collective/homebrew-tap/issues

    To switch to stable channel:
      brew uninstall --cask hive-consensus-beta
      (brew untap hivetechs-collective/tap 2>/dev/null; brew tap hivetechs-collective/tap)
      brew install --cask hivetechs-collective/tap/hive-consensus --force
  EOS
end
