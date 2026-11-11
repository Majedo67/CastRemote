# CastRemote

CastRemote is a starter project for an iPhone remote-control app and an Android TV companion app.

## Project layout

- `ios/` — SwiftUI iPhone app and XcodeGen project definition.
- `android-tv/` — Android TV companion app.
- `.github/workflows/` — GitHub Actions builds.

## Current status

This commit provides the app shells and automated build pipelines. It does **not** yet implement working TV pairing, remote commands, or media casting. Those features depend on the TV brand/model and supported protocols.

## Builds

- **Android:** GitHub Actions builds a debug APK.
- **iOS:** GitHub Actions builds an unsigned IPA. Import it into a signing tool such as Esign and sign it with a certificate/profile that is valid for your device. An unsigned IPA cannot be installed directly.

Open the **Actions** tab in GitHub to see the build results and download artifacts.

## Compatibility notes

- Android TV remote pairing and commands vary by TV and Android TV version.
- AirPlay, Google Cast, and Android TV remote control are separate technologies. This starter does not claim universal casting or screen mirroring.
- Volume and power controls may not be supported by every TV.
