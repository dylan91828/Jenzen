
import SwiftUI
import UIKit
import WebKit

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
    @State private var showBrowser = false

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
                Text("JENZEN")
                    .font(.system(size: 40, weight: .black))
                    .foregroundStyle(green)

                if !unlocked {
                    Spacer()

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
                    .overlay {
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(green, lineWidth: 1)
                    }
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

                    Spacer()
                } else if showBrowser {
                    HStack {
                        Text("PROXY JENZEN")
                            .font(.headline.bold())
                            .foregroundStyle(green)

                        Spacer()

                        Button("VOLVER") {
                            showBrowser = false
                        }
                        .foregroundStyle(green)
                    }

                    ProxyBrowser()
                        .clipShape(RoundedRectangle(cornerRadius: 14))
                        .overlay {
                            RoundedRectangle(cornerRadius: 14)
                                .stroke(green, lineWidth: 1)
                        }
                } else {
                    Spacer()

                    Text("PANEL PRINCIPAL")
                        .foregroundStyle(.white)
                        .font(.headline)

                    optionButton("AIMBOT NECK")
                    optionButton("ESP")

                    Spacer()
                }
            }
            .padding(25)
            .padding(.top, 65)
        }
        .alert(
            "ACTIVA EL VPN PARA CONTINUAR",
            isPresented: $showVPNAlert
        ) {
            Button("ACEPTAR") {
                showBrowser = true
            }

            Button("CANCELAR", role: .cancel) {}
        } message: {
            Text("Continúa en la página de activación.")
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

struct ProxyBrowser: UIViewRepresentable {
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.backgroundColor = .black
        webView.isOpaque = false

        if let url = URL(
            string: "https://proxy.vin/activate/"
        ) {
            webView.load(URLRequest(url: url))
        }

        return webView
    }

    func updateUIView(
        _ webView: WKWebView,
        context: Context
    ) {}
}
