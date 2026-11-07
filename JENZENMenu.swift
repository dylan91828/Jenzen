
import SwiftUI

@main
struct PapaMillonarioApp: App {
    var body: some Scene {
        WindowGroup {
            BancoView()
        }
    }
}

struct BancoView: View {
    @State private var seleccion = "Inicio"
    @State private var mostrarSaldo = true

    let dorado = Color(red: 0.91, green: 0.74, blue: 0.36)
    let fondo = Color(red: 0.055, green: 0.065, blue: 0.055)

    var body: some View {
        ZStack {
            fondo.ignoresSafeArea()

            VStack(spacing: 0) {
                HStack {
                    VStack(alignment: .leading) {
                        Text("PAPÁ MILLONARIO")
                            .font(.title2.bold())
                            .foregroundColor(dorado)
                        Text("BANCA PERSONAL")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }

                    Spacer()

                    Image(systemName: "bell.badge")
                        .font(.title2)
                        .foregroundColor(dorado)
                }
                .padding()

                ScrollView {
                    VStack(spacing: 20) {
                        saldoCard

                        LazyVGrid(
                            columns: [
                                GridItem(.flexible()),
                                GridItem(.flexible()),
                                GridItem(.flexible())
                            ],
                            spacing: 14
                        ) {
                            opcion("Transferir", "arrow.left.arrow.right")
                            opcion("Recibir", "arrow.down.left")
                            opcion("Pagar", "creditcard")
                            opcion("Recargas", "iphone")
                            opcion("Tarjetas", "rectangle.on.rectangle")
                            opcion("Bolsillos", "wallet.pass")
                            opcion("Movimientos", "list.bullet.rectangle")
                            opcion("Estadísticas", "chart.bar")
                            opcion("Ajustes", "gearshape")
                        }

                        VStack(alignment: .leading, spacing: 14) {
                            Text("MOVIMIENTOS RECIENTES")
                                .font(.headline)
                                .foregroundColor(dorado)

                            movimiento("Compra de ejemplo", "-$250.000")
                            movimiento("Ingreso de ejemplo", "+$1.500.000")
                            movimiento("Pago de ejemplo", "-$85.000")
                        }
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color.white.opacity(0.06))
                        .cornerRadius(18)

                        VStack(spacing: 6) {
                            Text("Hecho por Dylan Mendez, su hijo :)")
                                .foregroundColor(dorado)
                                .font(.footnote.bold())

                            Text("DEMO · DINERO FICTICIO")
                                .foregroundColor(.gray)
                                .font(.caption2)
                        }
                        .padding(.vertical)
                    }
                    .padding()
                }

                HStack {
                    tab("Inicio", "house.fill")
                    tab("Movimientos", "clock.arrow.circlepath")
                    tab("Tarjetas", "creditcard")
                    tab("Perfil", "person.fill")
                }
                .padding(.vertical, 12)
                .background(Color.black)
            }
        }
        .preferredColorScheme(.dark)
        .alert("Operación de demostración", isPresented: $mostrarAlerta) {
            Button("Aceptar", role: .cancel) {}
        } message: {
            Text("Esta función es solo visual. No mueve dinero real.")
        }
    }

    @State private var mostrarAlerta = false

    var saldoCard: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("SALDO TOTAL")
                    .font(.caption.bold())
                Spacer()
                Button {
                    mostrarSaldo.toggle()
                } label: {
                    Image(systemName: mostrarSaldo ? "eye" : "eye.slash")
                }
            }
            .foregroundColor(.white.opacity(0.8))

            Text(mostrarSaldo ? "$289.000.000" : "••••••••••")
                .font(.system(size: 34, weight: .bold))
                .foregroundColor(dorado)
                .minimumScaleFactor(0.7)
                .lineLimit(1)

            Text("PESOS COLOMBIANOS · COP")
                .font(.caption2)
                .foregroundColor(.white.opacity(0.7))

            Divider().overlay(.white.opacity(0.2))

            HStack {
                Label("Cuenta principal", systemImage: "building.columns")
                Spacer()
                Text("•••• 2026")
            }
            .font(.caption)
            .foregroundColor(.white)
        }
        .padding(20)
        .background(
            LinearGradient(
                colors: [
                    Color(red: 0.19, green: 0.25, blue: 0.18),
                    Color.black
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .overlay(
            RoundedRectangle(cornerRadius: 22)
                .stroke(dorado.opacity(0.6), lineWidth: 1)
        )
        .cornerRadius(22)
    }

    func opcion(_ nombre: String, _ icono: String) -> some View {
        Button {
            mostrarAlerta = true
        } label: {
            VStack(spacing: 10) {
                Image(systemName: icono)
                    .font(.system(size: 25))
                    .foregroundColor(dorado)

                Text(nombre)
                    .font(.caption.bold())
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 90)
            .background(Color.white.opacity(0.07))
            .cornerRadius(15)
        }
    }

    func movimiento(_ nombre: String, _ cantidad: String) -> some View {
        HStack {
            Image(systemName: "arrow.left.arrow.right")
                .foregroundColor(dorado)
            Text(nombre)
                .foregroundColor(.white)
            Spacer()
            Text(cantidad)
                .foregroundColor(cantidad.hasPrefix("+") ? .green : .white)
                .fontWeight(.bold)
        }
        .font(.caption)
    }

    func tab(_ nombre: String, _ icono: String) -> some View {
        Button {
            seleccion = nombre
            mostrarAlerta = true
        } label: {
            VStack(spacing: 5) {
                Image(systemName: icono)
                Text(nombre)
                    .font(.system(size: 9))
            }
            .foregroundColor(seleccion == nombre ? dorado : .gray)
            .frame(maxWidth: .infinity)
        }
    }
}
