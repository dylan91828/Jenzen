
import SwiftUI
import UIKit

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
    @State private var showVPNAlert = false

    private let neonGreen = Color(
        red: 0.15, green: 1.0, blue: 0.42
    )

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [
                    Color(red: 0.02, green: 0.07, blue: 0.04),
                    Color(red: 0.04, green: 0.13, blue: 0.07)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            VStack(spacing: 12) {
                Text("JENZEN")
                    .font(.system(size: 36, weight: .black))
                    .foregroundStyle(neonGreen)

                Text("MENU")
                    .font(.system(size: 13, weight: .bold))
                    .tracking(4)
                    .foregroundStyle(.white.opacity(0.8))

                Spacer()
            }
            .padding(.top, 80)
        }
        .overlay(alignment: .bottomTrailing) {
            VStack(alignment: .trailing, spacing: 12) {
                if menuOpen {
                    VStack(alignment: .leading, spacing: 16) {
                        Text("MENU")
                            .font(.system(size: 20, weight: .black))
                            .foregroundStyle(neonGreen)

                        optionButton("AIMBOT NECK")
                        Divider().overlay(.white.opacity(0.2))
                        optionButton("ESP")
                    }
                    .padding(18)
                    .frame(width: 245)
                    .background(.black.opacity(0.94))
                    .overlay(
                        RoundedRectangle(cornerRadius: 18)
                            .stroke(neonGreen, lineWidth: 1.5)
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
                        Image(systemName: menuOpen ? "xmark" : "circle.hexagongrid.fill")
                        Text("JENZEN")
                            .font(.system(size: 13, weight: .black))
                    }
                    .foregroundStyle(.black)
                    .padding(.horizontal, 18)
                    .frame(height: 55)
                    .background(neonGreen)
                    .clipShape(Capsule())
                    .shadow(color: neonGreen.opacity(0.4), radius: 12)
                }
                .buttonStyle(.plain)
            }
            .padding(22)
        }
        .alert("¿ACTIVAR VPN?", isPresented: $showVPNAlert) {
            Button("ACTIVAR") {
                if let url = URL(string: "App-Prefs:root=VPN") {
                    UIApplication.shared.open(url)
                }
            }
            Button("CANCELAR", role: .cancel) {}
        } message: {
            Text("Abre los ajustes del iPhone para activar tu VPN.")
        }
        .preferredColorScheme(.dark)
    }

    private func optionButton(_ title: String) -> some View {
        Button {
            showVPNAlert = true
        } label: {
            HStack {
                Text(title)
                    .font(.system(size: 13, weight: .heavy))
                    .foregroundStyle(.white)

                Spacer()

                Image(systemName: "power")
                    .foregroundStyle(neonGreen)
            }
            .padding(.vertical, 8)
        }
        .buttonStyle(.plain)
    }
}
