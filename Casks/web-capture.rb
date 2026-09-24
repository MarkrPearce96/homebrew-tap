cask "web-capture" do
  version "1.0.2"
  sha256 "53b2e13fa350ab7fb70a1cd21d642d370dae44c1e5a7184438c35e807b53a852"

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
    Privacy & Security > Full Disk Access) before running --zap fixes
    this (confirmed) — re-run brew uninstall --zap web-capture afterward
    and those folders are removed too. --zap also does not remove
    Safari's own record of the extension, at
    ~/Library/Containers/com.apple.Safari/Data/Library/WebKit/WebExtensions/Default/com.markpearce.WebCapture.Extension (UNSIGNED)/
    — confirmed this persists even after a full uninstall, so remove it
    by hand if you want Safari to fully forget the extension.
  EOS
end
