cask "web-capture" do
  version "1.0.0"
  sha256 "47c8df9eac86667d5e194088ed2178e9709145b524598cd62abdb7e90e68a937"

  url "https://github.com/MarkrPearce96/Web-Capture/releases/download/v#{version}/WebCapture.zip"
  name "Web Capture"
  desc "Safari full-page screenshot and annotation extension"
  homepage "https://github.com/MarkrPearce96/Web-Capture"

  auto_updates false
  depends_on macos: :tahoe

  app "Web Capture.app"

  zap trash: [
    "~/Library/Application Scripts/com.markpearce.WebCapture",
    "~/Library/Application Scripts/com.markpearce.WebCapture.Extension",
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
      1. Open it once (double-click or right-click > Open). If Gatekeeper
         blocks it, go to System Settings > Privacy & Security, scroll
         down, and click "Open Anyway" next to the Web Capture warning
         (only needed once).
      2. In Safari: Settings > Advanced > check "Show Develop menu",
         then Develop > "Allow Unsigned Extensions" (resets each time
         Safari fully quits).
      3. Enable the extension in Safari > Settings > Extensions.

    `brew uninstall --zap web-capture` removes the app, its helper folders,
    preferences, and caches. macOS itself protects sandbox container
    metadata from deletion by ordinary processes (even a plain `rm -rf` in
    Terminal fails with "Operation not permitted" on
    .com.apple.containermanagerd.metadata.plist), so
    ~/Library/Containers/com.markpearce.WebCapture(.Extension) may survive
    --zap. Granting your terminal app Full Disk Access (System Settings >
    Privacy & Security > Full Disk Access) before running --zap is the
    standard fix for this class of restriction. It also does not remove
    Safari's own record that the extension was once installed — Safari
    drops that on its own once the app is gone.
  EOS
end
