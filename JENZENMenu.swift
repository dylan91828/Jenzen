import SwiftUI

@main
struct JENZENMenuApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView().preferredColorScheme(.dark)
        }
    }
}

struct ContentView: View {
    @State private var menuOpen = true
    @State private var fov = 45.0
    @State private var states: [String: Bool] = [:]

    private let options: [(String, String)] = [
        ("AIMBOT", "scope"),
        ("AIMBOT NECK", "target"),
        ("AIMBOT HEAD", "viewfinder"),
        ("SILENT AIM", "eye.slash"),
        ("NO RECOIL", "arrow.down.to.line"),
        ("ESP", "person.crop.circle"),
        ("WALLHACK", "square.3.layers.3d"),
        ("SPEED HACK", "bolt.fill"),
        ("AIM LOCK", "lock.fill")
    ]

    var body: some View {
        ZStack {
            Color(red: 0.025, green: 0.025, blue: 0.035).ignoresSafeArea()
            RadialGradient(colors: [.red.opacity(0.22), .clear],
                           center: .topTrailing, startRadius: 5, endRadius: 430)
                .ignoresSafeArea()

            VStack(spacing: 18) {
                HStack {
                    VStack(alignment: .leading, spacing: 5) {
                        Text("JENZEN")
                            .font(.system(size: 32, weight: .black, design: .rounded))
                            .tracking(3)
                        Text("VISUAL MENU • iOS EDITION")
                            .font(.system(size: 10, weight: .bold, design: .monospaced))
                            .tracking(1.5).foregroundStyle(.red)
                    }
                    Spacer()
                    Text("DEMO")
                        .font(.system(size: 11, weight: .black, design: .monospaced))
                        .foregroundStyle(.red)
                        .padding(.horizontal, 12).padding(.vertical, 8)
                        .overlay(Capsule().stroke(.red.opacity(0.7)))
                }

                HStack {
                    Label("CONTROL PANEL", systemImage: "slider.horizontal.3")
                        .font(.system(size: 12, weight: .bold, design: .monospaced))
                        .foregroundStyle(.white.opacity(0.8))
                    Spacer()
                    Button(menuOpen ? "HIDE" : "SHOW") {
                        withAnimation(.spring()) { menuOpen.toggle() }
                    }
                    .font(.system(size: 10, weight: .black, design: .monospaced))
                    .foregroundStyle(.white).padding(.horizontal, 14).padding(.vertical, 8)
                    .background(.red, in: Capsule())
                }

                if menuOpen {
                    VStack(spacing: 0) {
                        ForEach(options, id: \.0) { item in
                            HStack(spacing: 12) {
                                Image(systemName: item.1).foregroundStyle(.red)
                                    .frame(width: 23)
                                Text(item.0)
                                    .font(.system(size: 12, weight: .bold, design: .monospaced))
                                    .tracking(0.7)
                                Spacer()
                                Toggle("", isOn: Binding(
                                    get: { states[item.0] ?? false },
                                    set: { states[item.0] = $0 }
                                )).labelsHidden().tint(.red).scaleEffect(0.82)
                            }
                            .padding(.horizontal, 14).padding(.vertical, 9)
                            if item.0 != options.last?.0 {
                                Rectangle().fill(.white.opacity(0.07)).frame(height: 1)
                                    .padding(.leading, 48)
                            }
                        }
                    }
                    .background(Color(white: 0.085))
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .overlay(RoundedRectangle(cornerRadius: 16)
                        .stroke(.red.opacity(0.38), lineWidth: 1))

                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Text("AIM FOV")
                            Spacer()
                            Text("\(Int(fov))°").foregroundStyle(.red)
                        }
                        .font(.system(size: 11, weight: .bold, design: .monospaced))
                        Slider(value: $fov, in: 5...120, step: 1).tint(.red)
                    }
                    .padding(14)
                    .background(.white.opacity(0.05), in: RoundedRectangle(cornerRadius: 14))
                }

                Spacer(minLength: 5)
                Text("VISUAL DEMO ONLY — DOES NOT AFFECT ANY GAME")
                    .font(.system(size: 9, weight: .bold, design: .monospaced))
                    .foregroundStyle(.white.opacity(0.45))
                    .multilineTextAlignment(.center)
            }
            .padding(20)
        }
    }
}
