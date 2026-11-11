import SwiftUI

@main
struct CastRemoteApp: App {
    var body: some Scene {
        WindowGroup {
            RemoteHomeView()
                .preferredColorScheme(.dark)
        }
    }
}

struct RemoteHomeView: View {
    @State private var selectedTab = 0
    @State private var connection = "Not connected"

    var body: some View {
        ZStack {
            Color(red: 0.025, green: 0.055, blue: 0.12).ignoresSafeArea()
            VStack(spacing: 22) {
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("CASTREMOTE")
                            .font(.system(size: 25, weight: .black, design: .rounded))
                            .foregroundStyle(.cyan)
                        Text(connection)
                            .font(.caption)
                            .foregroundStyle(.white.opacity(0.65))
                    }
                    Spacer()
                    Image(systemName: "tv")
                        .font(.system(size: 28))
                        .foregroundStyle(.cyan)
                }

                Picker("Mode", selection: $selectedTab) {
                    Text("Remote").tag(0)
                    Text("Cast").tag(1)
                }
                .pickerStyle(.segmented)

                if selectedTab == 0 {
                    remotePad
                } else {
                    VStack(spacing: 14) {
                        Image(systemName: "airplayvideo")
                            .font(.system(size: 48))
                            .foregroundStyle(.cyan)
                        Text("Media casting")
                            .font(.title2.bold())
                        Text("Casting support will be added for compatible TV protocols.")
                            .multilineTextAlignment(.center)
                            .foregroundStyle(.white.opacity(0.65))
                        Button("Find compatible TVs") {
                            connection = "Discovery is not implemented yet"
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(.cyan)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                Spacer(minLength: 0)
                Text("Connect and control compatible TVs on your Wi-Fi")
                    .font(.caption)
                    .foregroundStyle(.white.opacity(0.45))
                    .multilineTextAlignment(.center)
            }
            .padding(24)
        }
    }

    private var remotePad: some View {
        VStack(spacing: 18) {
            HStack {
                remoteButton("power", title: "Power")
                Spacer()
                remoteButton("house", title: "Home")
                Spacer()
                remoteButton("chevron.left", title: "Back")
            }

            VStack(spacing: 8) {
                padButton("chevron.up")
                HStack(spacing: 36) {
                    padButton("chevron.left")
                    padButton("checkmark", size: 66)
                    padButton("chevron.right")
                }
                padButton("chevron.down")
            }
            .padding(.vertical, 18)

            HStack {
                remoteButton("speaker.wave.2", title: "Volume")
                Spacer()
                remoteButton("playpause", title: "Play / Pause")
            }
            Text("Buttons are visual placeholders until TV pairing is implemented.")
                .font(.caption2)
                .foregroundStyle(.white.opacity(0.45))
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
    }

    private func padButton(_ symbol: String, size: CGFloat = 54) -> some View {
        Button {} label: {
            Image(systemName: symbol)
                .font(.title2.bold())
                .foregroundStyle(.white)
                .frame(width: size, height: size)
                .background(Color.white.opacity(0.12), in: Circle())
                .overlay(Circle().stroke(Color.cyan.opacity(0.35), lineWidth: 1))
        }
        .buttonStyle(.plain)
    }

    private func remoteButton(_ symbol: String, title: String) -> some View {
        Button {} label: {
            VStack(spacing: 6) {
                Image(systemName: symbol).font(.title3)
                Text(title).font(.caption2)
            }
            .foregroundStyle(.white)
            .frame(minWidth: 58, minHeight: 54)
        }
        .buttonStyle(.plain)
    }
}
