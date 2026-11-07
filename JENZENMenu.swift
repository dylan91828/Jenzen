
import SwiftUI
import UIKit
import WebKit

@main
struct DYLANApp: App {
    var body: some Scene {
        WindowGroup {
            DYLANMenuView()
        }
    }
}

struct DYLANMenuView: View {
    @State private var key = ""
    @State private var unlocked = false
    @State private var error = false
    @State private var showVPNAlert = false
    @State private var showBrowser = false

    private let yellow = Color(
        red: 1.0, green: 0.85, blue: 0.0
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
                    Color(red: 0.12, green: 0.10, blue: 0.01)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack(spacing: 24) {
                Text("DYLAN")
                    .font(.system(size: 40, weight: .black))
                    .foregroundStyle(yellow)

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
                            .stroke(yellow, lineWidth: 1)
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
                    .background(yellow)
                    .clipShape(RoundedRectangle(cornerRadius: 12))

                    if error {
                        Text("KEY INVÁLIDA")
                            .foregroundStyle(.red)
                    }

                    Spacer()

                } else if showBrowser {
                    HStack {
                        Text("DYLAN PROXY")
                            .font(.headline.bold())
                            .foregroundStyle(yellow)

                        Spacer()

                        Button("VOLVER") {
                            showBrowser = false
                        }
                        .foregroundStyle(yellow)
                    }

                    ProxyBrowser()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)

                } else {
                    Spacer()

                    Text("DYLAN PANEL")
                        .foregroundStyle(.white)
                        .font(.headline)

                    optionButton("AIMBOT NECK")
                    optionButton("ESP")

                    Spacer()
                }
            }
            .padding(25)
            .padding(.top, 55)
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
            .background(yellow)
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
    }
}

struct ProxyBrowser: View {
    private let yellow = Color(
        red: 1.0, green: 0.85, blue: 0.0
    )

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Image(systemName: "shield.lefthalf.filled")

                Text("DYLAN PROXY")
                    .font(.system(size: 17, weight: .black))
                    .tracking(2)

                Spacer()

                Circle()
                    .fill(yellow)
                    .frame(width: 9, height: 9)
            }
            .foregroundStyle(yellow)
            .padding(16)
            .background(.black)

            ProxyWebView()
        }
        .background(.black)
        .overlay {
            RoundedRectangle(cornerRadius: 14)
                .stroke(yellow, lineWidth: 1)
        }
        .clipShape(RoundedRectangle(cornerRadius: 14))
    }
}

struct ProxyWebView: UIViewRepresentable {
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
