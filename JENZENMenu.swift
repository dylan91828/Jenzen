
import SwiftUI
import WebKit

private let verdeJenzen = Color(
    red: 0.15,
    green: 1.0,
    blue: 0.42
)

@main
struct JENZENApp: App {
    var body: some Scene {
        WindowGroup {
            JENZENMenu()
                .preferredColorScheme(.dark)
        }
    }
}

struct JENZENMenu: View {
    @State private var key = ""
    @State private var entrar = false
    @State private var mostrarProxy = false
    @State private var mostrarAlerta = false
    @State private var mensaje = ""

    private var keyValida: Bool {
        key.range(
            of: "^[A-Za-z0-9]{5}(-[A-Za-z0-9]{5}){3}$",
            options: .regularExpression
        ) != nil
    }

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            if entrar {
                menuPrincipal
            } else {
                pantallaKey
            }
        }
        .alert("JENZEN", isPresented: $mostrarAlerta) {
            Button("Aceptar", role: .cancel) {}
        } message: {
            Text(mensaje)
        }
    }

    private var pantallaKey: some View {
        VStack(spacing: 25) {
            Spacer()

            Text("JENZEN")
                .font(.system(size: 43, weight: .black))
                .foregroundColor(verdeJenzen)

            Text("OFFICIAL PANEL")
                .tracking(5)
                .foregroundColor(.white)

            TextField(
                "XXXXX-XXXXX-XXXXX-XXXXX",
                text: $key
            )
            .textInputAutocapitalization(.characters)
            .autocorrectionDisabled()
            .padding()
            .background(Color.white.opacity(0.08))
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(verdeJenzen, lineWidth: 1.5)
            )
            .foregroundColor(.white)

            Button {
                if keyValida {
                    entrar = true
                } else {
                    mensaje = "La key no tiene el formato correcto."
                    mostrarAlerta = true
                }
            } label: {
                Text("ENTRAR")
                    .fontWeight(.black)
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(verdeJenzen)
                    .cornerRadius(12)
            }

            Spacer()

            Text("JENZEN PANEL")
                .foregroundColor(.gray)
                .font(.caption)
        }
        .padding(28)
    }

    private var menuPrincipal: some View {
        VStack(spacing: 20) {
            Text("JENZEN")
                .font(.system(size: 35, weight: .black))
                .foregroundColor(verdeJenzen)

            Text("MAIN PANEL")
                .foregroundColor(.white)
                .tracking(4)

            Button {
                mostrarProxy = true
            } label: {
                boton("PROXY JENZEN")
            }

            Spacer()

            Text("JENZEN OFFICIAL")
                .foregroundColor(.gray)
                .font(.caption)
        }
        .padding(25)
        .fullScreenCover(isPresented: $mostrarProxy) {
            ProxyJenzen()
        }
    }

    private func boton(_ titulo: String) -> some View {
        Text(titulo)
            .font(.system(size: 17, weight: .bold))
            .foregroundColor(verdeJenzen)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 19)
            .background(Color.white.opacity(0.06))
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(verdeJenzen, lineWidth: 1.5)
            )
            .cornerRadius(12)
            .contentShape(Rectangle())
    }
}

// MARK: - Página Proxy

struct ProxyJenzen: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(verdeJenzen)
                }

                Spacer()

                Text("PROXY JENZEN")
                    .font(.system(size: 19, weight: .black))
                    .foregroundColor(verdeJenzen)

                Spacer()

                Image(systemName: "globe")
                    .foregroundColor(verdeJenzen)
            }
            .padding()
            .background(Color.black)

            ProxyWebView()
                .background(Color.white)
                .ignoresSafeArea(edges: .bottom)
        }
        .background(Color.black)
        .preferredColorScheme(.dark)
    }
}

// MARK: - Navegador integrado

struct ProxyWebView: UIViewRepresentable {

    func makeUIView(context: Context) -> WKWebView {
        let configuracion = WKWebViewConfiguration()

        let webView = WKWebView(
            frame: .zero,
            configuration: configuracion
        )

        webView.navigationDelegate = context.coordinator
        webView.uiDelegate = context.coordinator
        webView.allowsBackForwardNavigationGestures = true

        webView.scrollView.isScrollEnabled = true
        webView.scrollView.minimumZoomScale = 1.0
        webView.scrollView.maximumZoomScale = 3.0
        webView.scrollView.bounces = true

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

    func makeCoordinator() -> Coordinator {
        Coordinator()
    }

    class Coordinator: NSObject,
                       WKNavigationDelegate,
                       WKUIDelegate {

        // Abre enlaces que solicitan una ventana nueva.
        func webView(
            _ webView: WKWebView,
            createWebViewWith configuration: WKWebViewConfiguration,
            for navigationAction: WKNavigationAction,
            windowFeatures: WKWindowFeatures
        ) -> WKWebView? {

            if let url = navigationAction.request.url {
                abrirEnlace(url)
            }

            return nil
        }

        // Detecta enlaces a perfiles VPN y los abre en Safari.
        func webView(
            _ webView: WKWebView,
            decidePolicyFor navigationAction: WKNavigationAction,
            decisionHandler: @escaping (WKNavigationActionPolicy) -> Void
        ) {
            guard let url = navigationAction.request.url else {
                decisionHandler(.allow)
                return
            }

            let extensionArchivo =
                url.pathExtension.lowercased()

            if extensionArchivo == "mobileconfig" {
                abrirEnlace(url)
                decisionHandler(.cancel)
                return
            }

            decisionHandler(.allow)
        }

        private func abrirEnlace(_ url: URL) {
            DispatchQueue.main.async {
                UIApplication.shared.open(
                    url,
                    options: [:],
                    completionHandler: nil
                )
            }
        }

        func webView(
            _ webView: WKWebView,
            didFinish navigation: WKNavigation!
        ) {
            let javascript = """
            (function() {
                var viewport = document.querySelector(
                    'meta[name="viewport"]'
                );

                if (!viewport) {
                    viewport = document.createElement('meta');
                    viewport.name = 'viewport';
                    document.head.appendChild(viewport);
                }

                viewport.content =
                    'width=device-width, initial-scale=1.0, maximum-scale=3.0, user-scalable=yes';

                document.documentElement.style.maxWidth = '100%';
                document.documentElement.style.overflowX = 'auto';

                document.body.style.maxWidth = '100%';
                document.body.style.margin = '0';
            })();
            """

            webView.evaluateJavaScript(javascript)
        }
    }
}
