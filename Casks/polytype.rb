cask "polytype" do
  version "1.1.4"
  sha256 "8394984a44203dfeb9f8ac94c385f1b0f59e34a4c4737a7181eead1c30193ad3"

  url "https://github.com/MarkrPearce96/Polytype/releases/download/v#{version}/Polytype.zip"
  name "Polytype"
  desc "Menu-bar app that translates text in place with a global hotkey"
  homepage "https://github.com/MarkrPearce96/Polytype"

  auto_updates false
  depends_on arch: :arm64
  depends_on macos: :sonoma

  app "Polytype.app"

  # `defaults delete` (not just trashing the plist) matters here: cfprefsd
  # caches a preference domain in memory, so deleting the file alone can
  # leave a reinstalled copy of the app reading (or even rewriting) the old
  # cached values — including `setupCompleted`, which then skips first-run
  # setup on a supposedly-fresh install. `defaults delete` goes through
  # cfprefsd itself, so the cache is actually cleared, not just the file.
  zap script: {
        executable: "/bin/sh",
        args:       ["-c",
                     "defaults delete com.polytype.bar 2>/dev/null; defaults delete PolytypeBar 2>/dev/null; true"],
      },
      trash:  [
        "~/Library/Caches/com.polytype.bar/",
        "~/Library/HTTPStorages/com.polytype.bar/",
        "~/Library/Preferences/com.polytype.bar.plist",
        "~/Library/Preferences/PolytypeBar.plist",
      ]

  caveats <<~EOS
    Polytype is signed with a personal Apple Development certificate but
    not notarized (personal use, no paid Apple Developer account). On
    first launch:
      1. Open it once. If Gatekeeper blocks it, go to System Settings >
         Privacy & Security, scroll down, and click "Open Anyway" next to
         the Polytype warning (only needed once). Right-click > Open does
         not reliably bypass this on current macOS.
      2. Grant Accessibility permission when asked (System Settings >
         Privacy & Security > Accessibility > enable "Polytype"). This
         lets the hotkey read and replace your selected text. Because the
         app is always signed with the same certificate, this grant
         survives future `brew upgrade --cask polytype` updates.
      3. Open the menu-bar icon (globe) > Settings to add your Google
         Cloud Translation API key, or skip it to use Apple's free
         on-device translation only.

    `brew uninstall --zap polytype` removes the app and its preferences.
    It does NOT remove the saved Google Translation API key, which is
    stored in the login Keychain under the service name
    "com.polytype.secrets" — remove it manually via Keychain Access if
    you want it gone too.

    Polytype ships as an arm64-only (Apple Silicon) binary — it will not
    run on an Intel Mac.
  EOS
end
