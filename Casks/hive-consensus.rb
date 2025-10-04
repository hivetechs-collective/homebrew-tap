cask "hive-consensus" do
  version "1.8.518"
  sha256 "2655be4e6b5dd322b9e1e9c385cbef62986d7069d00ae58f15d5b7d4d70bd4a9"

  url "https://github.com/hivetechs-collective/Hive/releases/download/v#{version}/Hive.Consensus.dmg"
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
