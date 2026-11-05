cask "cornerstack" do
  version "1.2.0"
  sha256 "a90b773d5b09eda528ede2b5a7945542bd486b24cb828ceabeef86843212940d"

  url "https://github.com/nemcaya/cornerstack/releases/download/v#{version}/Cornerstack-#{version}.dmg"
  name "Cornerstack"
  desc "Stack of your latest screenshots in the corner of the screen"
  homepage "https://github.com/nemcaya/cornerstack"

  depends_on macos: :sonoma

  app "Cornerstack.app"

  # Cornerstack is signed ad hoc, not notarized, so macOS would refuse to open
  # it until you allow it in System Settings. This does what the README's
  # xattr command does.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/Cornerstack.app"]
  end

  # Quitting puts your screenshot settings back, if Cornerstack handled them.
  uninstall quit: "io.github.nemcaya.cornerstack"

  # Your screenshots in ~/Library/Application Support/Cornerstack are left alone.
  zap trash: "~/Library/Preferences/io.github.nemcaya.cornerstack.plist"
end
