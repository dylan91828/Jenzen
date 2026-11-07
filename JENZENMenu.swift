
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
    @State private var error = false

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
                colors: [.black, Color(red: 0.02, green: 0.12, blue: 0.06)],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack(spacing: 22) {
                Spacer()

                Text("JENZEN")
                    .font(.system(size: 42, weight: .black))
                    .foregroundStyle(green)

                Text("KEY DEL PANEL")
                    .font(.system(size: 17, weight: .bold))
                    .tracking(3)
                    .foregroundStyle(.white)

                TextField("XXXXX-XXXXX-XXXXX-XXXXX", text: $key)
                    .textInputAutocapitalization(.characters)
                    .autocorrectionDisabled()
                    .padding()
                    .background(.white.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(green, lineWidth: 1)
                    )
                    .foregroundStyle(.white)

                Button {
                    if validKey {
                        UIApplication.shared.open(
                            URL(string: UIApplication.openSettingsURLString)!
                        )
                    } else {
                        error = true
                    }
                } label: {
                    Text("VERIFICAR")
                        .font(.system(size: 16, weight: .black))
                        .foregroundStyle(.black)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(green)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }

                if error {
                    Text("KEY INVÁLIDA. REVISA EL FORMATO.")
                        .font(.system(size: 12, weight: .bold))
                        .foregroundStyle(.red)
                }

                Spacer()
            }
            .padding(28)
        }
        .preferredColorScheme(.dark)
    }
}
