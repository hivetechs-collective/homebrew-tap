cask "hive-consensus-beta" do
  version "1.8.749"
  sha256 "dd190bb3778579e7a4f7dd7a061a95541842055872adf5399914d9c5884654b8"

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
    🧪 BETA v1.8.708 - OpenRouter API Key Fix

    FIXED in this beta:
    - ✅ OpenRouter API key retrieval using SafeStorageService
    - ✅ Proper encrypted keychain access for API credentials
    - ✅ Resolves "No API key configured" errors on launch

    Features in this beta:
    - 🌐 OpenRouter PTY Terminal - Access 500+ AI models
    - 🔀 Model switching mid-conversation
    - 💰 Real-time cost tracking and token counting
    - 🔍 Fuzzy search across all OpenRouter models
    - 📊 Streaming responses in terminal
    - 🎯 Activity bar integration (purple router icon)

    How to test OpenRouter:
    1. Click the purple router icon in the activity bar
    2. Configure your OpenRouter API key (one-time setup)
    3. Select a model from the terminal prompt
    4. Start chatting with any of 500+ AI models
    5. Use /models to switch models anytime
    6. Use /help to see all commands

    To report issues or provide feedback:
    https://github.com/hivetechs-collective/homebrew-tap/issues

    To switch back to stable (v1.8.705):
      brew uninstall --cask hive-consensus-beta
      brew install --cask hive-consensus
  EOS
end
