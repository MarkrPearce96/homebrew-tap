cask "polytype" do
  version "1.1.1"
  sha256 "f24ff5979d3125296588878ed8cef60545d7157ab81c135094d722fa1a0c91fe"

  url "https://github.com/MarkrPearce96/Polytype/releases/download/v#{version}/Polytype.zip"
  name "Polytype"
  desc "Menu-bar app that translates text in place with a global hotkey"
  homepage "https://github.com/MarkrPearce96/Polytype"

  auto_updates false
  depends_on arch: :arm64
  depends_on macos: :sonoma

  app "Polytype.app"

  zap trash: "~/Library/Preferences/com.polytype.bar.plist"

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
