
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
    @State private var key = ""
    @State private var unlocked = false
    @State private var error = false
    @State private var showVPNAlert = false

    private let green = Color(
        red: 0.15, green: 1.0, blue: 0.42
    )

    private var validKey: Bool {
        key.range(
            of: #"^[A-Za-z0-9]{5}(-[A-Za-z0-9]{5}){3}$"#,
            options: .regularExpression
        ) != nil
    }

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [
                    .black,
                    Color(red: 0.02, green: 0.12, blue: 0.06)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack(spacing: 24) {
                Spacer()

                Text("JENZEN")
                    .font(.system(size: 40, weight: .black))
                    .foregroundStyle(green)

                if !unlocked {
                    Text("KEY DEL PANEL")
                        .font(.headline)
                        .tracking(3)
                        .foregroundStyle(.white)

                    TextField(
                        "XXXXX-XXXXX-XXXXX-XXXXX",
                        text: $key
                    )
                    .textInputAutocapitalization(.characters)
                    .autocorrectionDisabled()
                    .padding()
                    .background(.white.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .foregroundStyle(.white)

                    Button("VERIFICAR") {
                        unlocked = validKey
                        error = !validKey
                    }
                    .font(.headline)
                    .foregroundStyle(.black)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(green)
                    .clipShape(RoundedRectangle(cornerRadius: 12))

                    if error {
                        Text("KEY INVÁLIDA")
                            .foregroundStyle(.red)
                    }
                } else {
                    Text("PANEL PRINCIPAL")
                        .foregroundStyle(.white)
                        .font(.headline)

                    optionButton("AIMBOT NECK")
                    optionButton("ESP")
                }

                Spacer()
            }
            .padding(28)
        }
        .alert(
            "ACTIVA EL VPN PARA CONTINUAR",
            isPresented: $showVPNAlert
        ) {
            Button("ACEPTAR") {
                if let url = URL(string: "App-Prefs:") {
                    UIApplication.shared.open(url)
                }
            }

            Button("CANCELAR", role: .cancel) {}
        } message: {
            Text("Activa tu VPN para continuar.")
        }
        .preferredColorScheme(.dark)
    }

    private func optionButton(_ title: String) -> some View {
        Button {
            showVPNAlert = true
        } label: {
            HStack {
                Text(title)
                    .font(.system(size: 15, weight: .heavy))

                Spacer()

                Image(systemName: "power")
            }
            .foregroundStyle(.black)
            .padding()
            .frame(maxWidth: .infinity)
            .background(green)
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
    }
}
