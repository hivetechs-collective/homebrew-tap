cask "hive-consensus" do
  version "1.8.527"
  sha256 "5bb5cf80e70ba2c3f09528d8ee3ceb2e15bb908f9b3e7133c6f9d33a6553a40e"

  url "https://github.com/hivetechs-collective/Hive/releases/download/v#{version}/Hive.Consensus-darwin-universal-#{version}.dmg"
  name "Hive Consensus"
  desc "AI-powered development environment with integrated terminals and consensus engine"
  homepage "https://github.com/hivetechs-collective/Hive"

  livecheck do
    url :url
    strategy :github_latest
  end

  app "Hive Consensus.app"

  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Hive Consensus.app"],
                   sudo: false
  end

  zap trash: [
    "~/Library/Application Support/Hive Consensus",
    "~/Library/Preferences/com.hivetechs.hive-consensus.plist",
    "~/Library/Saved Application State/com.hivetechs.hive-consensus.savedState",
    "~/Library/Logs/Hive Consensus",
  ]
end
