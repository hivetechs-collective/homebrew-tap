cask "hive-consensus" do
  version "1.8.526"
  sha256 "efd447be791bdd7ece9d9357b908d00a0f94633a091c9e009a0ca6388a3de43e"

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
