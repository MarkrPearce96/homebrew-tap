cask "web-capture" do
  version "1.0.3"
  sha256 "e2839f467bf19220e50e9ee8631cc6ec943c91bda8a53c2f11a9c9913ed7f4ff"

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
    "~/Library/Containers/com.apple.Safari/Data/Library/WebKit/WebExtensions/Default/com.markpearce.WebCapture.Extension (62P4GYN8E3)",
    "~/Library/Containers/com.markpearce.WebCapture",
    "~/Library/Containers/com.markpearce.WebCapture.Extension",
    "~/Library/HTTPStorages/com.markpearce.WebCapture",
    "~/Library/Preferences/com.markpearce.WebCapture.Extension.plist",
    "~/Library/Preferences/com.markpearce.WebCapture.plist",
    "~/Library/Saved Application State/com.markpearce.WebCapture.savedState",
    "~/Library/WebKit/com.markpearce.WebCapture",
  ]

  caveats <<~EOS
    Web Capture is signed with a personal Apple Development certificate but
    not notarized (personal use). On first launch:
      1. Open it once. If Gatekeeper blocks it, go to System Settings >
         Privacy & Security, scroll down, and click "Open Anyway" next to
         the Web Capture warning (only needed once). Right-click > Open
         does not reliably bypass this on current macOS.
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
    and those folders are removed too. --zap also attempts to remove
    Safari's own record of the extension (a folder Safari keeps inside
    its own container, confirmed to otherwise persist even after a full
    uninstall) — this reaches into another app's sandboxed data, so it
    may hit the same "Operation not permitted" restriction as the
    Containers folders above and require the same Full Disk Access fix,
    or it may just silently fail to remove it; check for yourself if it
    matters to you.
  EOS
end
