
import SwiftUI

@main
struct JENZENApp: App {
    var body: some Scene {
        WindowGroup {
            JENZENMenuView()
        }
    }
}

struct JENZENMenuView: View {
    @State private var menuOpen = false
    @State private var aimbotNeckOn = false
    @State private var espOn = false
    @State private var bubblePosition = CGSize.zero

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [
                    Color(red: 0.04, green: 0.05, blue: 0.10),
                    Color(red: 0.10, green: 0.06, blue: 0.18)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            VStack(spacing: 12) {
                Text("JENZEN")
                    .font(.system(size: 36, weight: .black))
                    .foregroundStyle(.white)

                Text("VISUAL MENU")
                    .font(.system(size: 12, weight: .bold))
                    .tracking(3)
                    .foregroundStyle(.cyan)

                Spacer()
            }
            .padding(.top, 80)
        }
        .overlay(alignment: .bottomTrailing) {
            VStack(alignment: .trailing, spacing: 12) {

                if menuOpen {
                    VStack(alignment: .leading, spacing: 16) {
                        Text("JENZEN")
                            .font(.system(size: 19, weight: .black))
                            .foregroundStyle(.cyan)

                        Divider().overlay(.white.opacity(0.2))

                        settingRow(
                            title: "AIMBOT NECK",
                            isOn: $aimbotNeckOn
                        )

                        Divider().overlay(.white.opacity(0.2))

                        settingRow(
                            title: "ESP",
                            isOn: $espOn
                        )

                        Text("VISUAL DEMO")
                            .font(.system(size: 9, weight: .bold))
                            .foregroundStyle(.white.opacity(0.4))
                    }
                    .padding(16)
                    .frame(width: 235)
                    .background(.black.opacity(0.92))
                    .overlay(
                        RoundedRectangle(cornerRadius: 18)
                            .stroke(.cyan, lineWidth: 1.3)
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 18))
                    .transition(.opacity.combined(with: .scale))
                }

                Button {
                    withAnimation(.spring()) {
                        menuOpen.toggle()
                    }
                } label: {
                    HStack(spacing: 8) {
                        Image(systemName: menuOpen ? "xmark" : "scope")
                        Text("JENZEN")
                            .font(.system(size: 12, weight: .black))
                    }
                    .foregroundStyle(.black)
                    .padding(.horizontal, 17)
                    .frame(height: 54)
                    .background(.cyan)
                    .clipShape(Capsule())
                    .shadow(color: .cyan.opacity(0.4), radius: 12)
                }
                .buttonStyle(.plain)
                .offset(bubblePosition)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            bubblePosition = value.translation
                        }
                )
            }
            .padding(22)
        }
        .preferredColorScheme(.dark)
    }

    private func settingRow(
        title: String,
        isOn: Binding<Bool>
    ) -> some View {
        HStack {
            Text(title)
                .font(.system(size: 13, weight: .heavy))
                .foregroundStyle(.white)

            Spacer()

            Toggle(title, isOn: isOn)
                .labelsHidden()
                .tint(.cyan)
                .scaleEffect(0.85)
        }
    }
}
