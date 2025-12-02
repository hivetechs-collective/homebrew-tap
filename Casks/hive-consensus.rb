cask "hive-consensus" do
  version "1.8.808"
  sha256 "d4d11189463871ae3b3e180b76a05a027094ad619bc4b6333a37b183b53cdc1e"

  url "https://github.com/hivetechs-collective/homebrew-tap/releases/download/v#{version}/Hive-Consensus-#{version}.dmg"
  name "Hive Consensus"
  desc "AI development environment with integrated terminals and consensus"
  homepage "https://github.com/hivetechs-collective/homebrew-tap"

  livecheck do
    url :url
    strategy :github_latest
  end

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
end
