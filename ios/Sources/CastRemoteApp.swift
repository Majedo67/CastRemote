import SwiftUI
import Network

@main
struct CastRemoteApp: App {
    var body: some Scene {
        WindowGroup {
            RemoteHomeView()
                .preferredColorScheme(.dark)
        }
    }
}

@MainActor
final class TVDiscovery: ObservableObject {
    @Published var devices: [String] = []
    @Published var status = "Ready to scan"
    private var browser: NWBrowser?

    func start() {
        stop()
        devices = []
        status = "Searching for Android TV devices…"

        let browser = NWBrowser(
            for: .bonjour(type: "_androidtvremote2._tcp", domain: nil),
            using: .tcp
        )
        self.browser = browser
        browser.stateUpdateHandler = { [weak self] state in
            Task { @MainActor in
                switch state {
                case .ready:
                    self?.status = "Searching on your Wi-Fi…"
                case .failed(let error):
                    self?.status = "Scan failed: \(error.localizedDescription)"
                case .waiting:
                    self?.status = "Waiting for network…"
                case .cancelled:
                    break
                default:
                    break
                }
            }
        }
        browser.browseResultsChangedHandler = { [weak self] results, _ in
            let names = results.compactMap { result -> String? in
                guard case let .service(name, _, _, _) = result.endpoint else { return nil }
                return name
            }.sorted()
            Task { @MainActor in
                self?.devices = names
                self?.status = names.isEmpty
                    ? "No compatible Android TV found yet"
                    : "Found \(names.count) compatible device(s)"
            }
        }
        browser.start(queue: .main)
    }

    func stop() {
        browser?.cancel()
        browser = nil
    }
}

struct RemoteHomeView: View {
    @StateObject private var discovery = TVDiscovery()
    @State private var selectedTV: String?

    var body: some View {
        ZStack {
            Color(red: 0.025, green: 0.055, blue: 0.12).ignoresSafeArea()
            VStack(spacing: 20) {
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("CASTREMOTE")
                            .font(.system(size: 25, weight: .black, design: .rounded))
                            .foregroundStyle(.cyan)
                        Text(selectedTV.map { "Selected: \($0)" } ?? "No TV selected")
                            .font(.caption)
                            .foregroundStyle(.white.opacity(0.65))
                    }
                    Spacer()
                    Image(systemName: "tv")
                        .font(.system(size: 28))
                        .foregroundStyle(.cyan)
                }

                VStack(spacing: 12) {
                    Image(systemName: "wifi")
                        .font(.system(size: 38))
                        .foregroundStyle(.cyan)
                    Text("Find your Android TV")
                        .font(.title2.bold())
                    Text(discovery.status)
                        .font(.caption)
                        .foregroundStyle(.white.opacity(0.7))
                        .multilineTextAlignment(.center)
                    Button {
                        discovery.start()
                    } label: {
                        Label("Scan for TVs", systemImage: "magnifyingglass")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.cyan)

                    if !discovery.devices.isEmpty {
                        ForEach(discovery.devices, id: \.self) { device in
                            Button {
                                selectedTV = device
                            } label: {
                                HStack {
                                    Image(systemName: "tv")
                                    Text(device)
                                    Spacer()
                                    if selectedTV == device {
                                        Image(systemName: "checkmark.circle.fill")
                                    }
                                }
                                .foregroundStyle(.white)
                                .padding(12)
                                .background(Color.white.opacity(0.1), in: RoundedRectangle(cornerRadius: 12))
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    Text("Your iPhone and TV must be on the same Wi-Fi. Discovery only finds compatible TVs; secure pairing and remote commands are not enabled yet.")
                        .font(.caption2)
                        .foregroundStyle(.white.opacity(0.5))
                        .multilineTextAlignment(.center)
                        .padding(.top, 4)
                }
                .frame(maxWidth: .infinity)
                Spacer()
            }
            .padding(24)
        }
        .onDisappear { discovery.stop() }
    }
}
