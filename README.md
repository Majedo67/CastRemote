# CastRemote

CastRemote is an iPhone app starter for discovering compatible Android TVs, with an Android TV companion app.

## Current status

- iPhone app can scan the local Wi-Fi network for Android TV Remote Service devices using Bonjour.
- Discovered device names can be selected in the app.
- Secure Android TV pairing, remote commands, and media casting are **not implemented yet**.
- The Android TV companion app is currently a starter screen; it is not required for standard Android TV Remote Service discovery.

## Build

- **Android:** GitHub Actions builds a debug APK.
- **iOS:** GitHub Actions builds an unsigned IPA. It must be signed with a valid certificate and provisioning profile before installation.

## Try discovery

1. Connect the iPhone and Android TV to the same Wi-Fi network.
2. Install and open CastRemote on the iPhone.
3. Allow the Local Network permission when iOS asks.
4. Tap **Scan for TVs**.

The TV must expose Android TV Remote Service over the local network. Not every TV firmware does. Finding a TV does not mean pairing or remote control is ready.

## Compatibility

Android TV remote pairing, commands, power, and volume support vary by TV model and firmware. Google Cast and AirPlay are separate from Android TV remote control; this app does not yet cast or mirror the iPhone screen.
