cask "web-capture" do
  version "1.0.0"
  sha256 "0000000000000000000000000000000000000000000000000000000000000000"

  url "https://github.com/MarkrPearce96/Web-Capture/releases/download/v#{version}/WebCapture.zip"
  name "Web Capture"
  desc "Safari full-page screenshot and annotation extension"
  homepage "https://github.com/MarkrPearce96/Web-Capture"

  auto_updates false
  depends_on macos: :tahoe

  app "Web Capture.app"

  zap trash: [
    "~/Library/Caches/com.markpearce.WebCapture",
    "~/Library/Containers/com.markpearce.WebCapture",
    "~/Library/Containers/com.markpearce.WebCapture.Extension",
    "~/Library/HTTPStorages/com.markpearce.WebCapture",
    "~/Library/Preferences/com.markpearce.WebCapture.Extension.plist",
    "~/Library/Preferences/com.markpearce.WebCapture.plist",
    "~/Library/Saved Application State/com.markpearce.WebCapture.savedState",
    "~/Library/WebKit/com.markpearce.WebCapture",
  ]

  caveats <<~EOS
    Web Capture is unsigned (personal use, not notarized). On first launch:
      1. Right-click "Web Capture" in Applications and choose "Open" to
         bypass Gatekeeper (only needed once).
      2. In Safari: Settings > Advanced > check "Show Develop menu",
         then Develop > "Allow Unsigned Extensions" (resets each time
         Safari fully quits).
      3. Enable the extension in Safari > Settings > Extensions.

    `brew uninstall --zap web-capture` removes the app's sandbox container,
    preferences, and caches. It does not remove Safari's own record that
    the extension was once installed — Safari drops that on its own once
    the app is gone.
  EOS
end
