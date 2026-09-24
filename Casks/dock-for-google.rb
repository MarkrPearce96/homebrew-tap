cask "dock-for-google" do
  version "1.1.0"
  sha256 "b8115c3e4831031288d7b628104807ccbe61d0d7b0f58339497ba580b824abd7"

  url "https://github.com/MarkrPearce96/Dock-for-Google/releases/download/v#{version}/Dock-for-Google-#{version}.zip"
  name "Dock for Google"
  desc "Searchable grid launcher for your favorite Google web apps in Safari"
  homepage "https://github.com/MarkrPearce96/Dock-for-Google"

  auto_updates false
  depends_on macos: :ventura

  app "Dock for Google.app"

  zap trash: [
    "~/Library/Application Scripts/com.mark.Dock-for-Google",
    "~/Library/Application Scripts/com.mark.Dock-for-Google.Extension",
    "~/Library/Containers/com.apple.Safari/Data/Library/WebKit/WebExtensions/Default/com.mark.Dock-for-Google.Extension (UNSIGNED)",
    "~/Library/Containers/com.mark.Dock-for-Google",
    "~/Library/Containers/com.mark.Dock-for-Google.Extension",
  ]

  caveats <<~EOS
    Dock for Google is unsigned (personal use, not notarized). On first launch:
      1. Open it once. If Gatekeeper blocks it, go to System Settings >
         Privacy & Security, scroll down, and click "Open Anyway" next to
         the warning (only needed once). Right-click > Open does not
         reliably bypass this on current macOS.
      2. In Safari: Settings > Advanced > check "Show features for web
         developers", then enable "Allow Unsigned Extensions" in
         Safari's Developer settings (resets each time Safari fully quits).
      3. Enable the extension in Safari > Settings > Extensions.

    `brew uninstall --zap dock-for-google` removes the app and its sandboxed
    container data (preferences, caches, and other state all live inside
    the container, not in the classic top-level Library folders). macOS
    itself protects sandbox container metadata from deletion by ordinary
    processes (even a plain `rm -rf` in Terminal fails with "Operation not
    permitted" on .com.apple.containermanagerd.metadata.plist), so
    ~/Library/Containers/com.mark.Dock-for-Google(.Extension) may survive
    --zap. Granting your terminal app Full Disk Access (System Settings >
    Privacy & Security > Full Disk Access) before running --zap fixes
    this, then re-run brew uninstall --zap dock-for-google. --zap also
    attempts to remove Safari's own record of the extension (kept inside
    Safari's own container) — that reaches into another app's sandboxed
    data, so it may hit the same restriction and require the same fix, or
    may just silently fail to remove it.
  EOS
end
