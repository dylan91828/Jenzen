
import SwiftUI

@main
struct BancoDeDylanApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

struct ContentView: View {
    @State private var entro = false

    var body: some View {
        Group {
            if entro {
                MenuPrincipal()
            } else {
                PantallaInicio {
                    withAnimation(.easeInOut) {
                        entro = true
                    }
                }
            }
        }
        .preferredColorScheme(.light)
    }
}

// MARK: - COLORES

extension Color {
    init(hex: String) {
        let value = UInt64(hex, radix: 16) ?? 0
        self.init(
            red: Double((value >> 16) & 0xFF) / 255,
            green: Double((value >> 8) & 0xFF) / 255,
            blue: Double(value & 0xFF) / 255
        )
    }
}

// MARK: - LOGO

struct LogoDylan: View {
    var body: some View {
        ZStack {
            Circle()
                .fill(.white)
                .frame(width: 112, height: 112)

            Text("D")
                .font(.system(size: 76, weight: .black))
                .foregroundStyle(
                    LinearGradient(
                        colors: [
                            Color(hex: "7800D5"),
                            Color(hex: "E500A4")
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )

            Capsule()
                .fill(
                    LinearGradient(
                        colors: [
                            Color(hex: "F000B5"),
                            Color(hex: "7900D8")
                        ],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .frame(width: 62, height: 13)
                .rotationEffect(.degrees(-35))
                .offset(x: 22, y: -32)
        }
    }
}

// MARK: - PANTALLA DE ENTRADA

struct PantallaInicio: View {
    var entrar: () -> Void

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [
                    Color(hex: "270044"),
                    Color(hex: "6900B8"),
                    Color(hex: "39005F")
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            Circle()
                .fill(Color(hex: "E500A4").opacity(0.20))
                .frame(width: 260)
                .blur(radius: 45)
                .offset(x: 140, y: -270)

            VStack(spacing: 24) {
                Spacer()

                LogoDylan()

                VStack(spacing: 7) {
                    Text("BANCO DE DYLAN")
                        .font(.system(size: 27, weight: .black))
                        .tracking(1)
                        .foregroundColor(.white)

                    Text("OFICIAL")
                        .font(.system(size: 12, weight: .bold))
                        .tracking(5)
                        .foregroundColor(Color(hex: "F5B9FF"))
                }

                Spacer()

                VStack(spacing: 18) {
                    Text("•••••• 85")
                        .font(.system(size: 22, weight: .semibold))
                        .tracking(3)
                        .foregroundColor(.white)

                    Button(action: entrar) {
                        Text("ENTRAR")
                            .font(.system(size: 17, weight: .bold))
                            .tracking(2)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 18)
                            .background(
                                LinearGradient(
                                    colors: [
                                        Color(hex: "F000A9"),
                                        Color(hex: "B000D9")
                                    ],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .clipShape(RoundedRectangle(cornerRadius: 18))
                    }

                    Text("DEMO · DINERO FICTICIO")
                        .font(.system(size: 10, weight: .bold))
                        .tracking(2)
                        .foregroundColor(.white.opacity(0.75))
                }

                Spacer()
            }
            .padding(.horizontal, 32)
        }
    }
}

// MARK: - MENU PRINCIPAL

struct MenuPrincipal: View {
    @State private var mostrarSaldo = true
    @State private var pestaña = "Inicio"
    @State private var aviso = false
    @State private var mensaje = ""

    let morado = Color(hex: "7100B9")
    let fondo = Color(hex: "F6F1FA")

    var body: some View {
        VStack(spacing: 0) {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 22) {

                    // ENCABEZADO
                    HStack {
                        HStack(spacing: 10) {
                            ZStack {
                                Circle()
                                    .fill(morado)
                                    .frame(width: 43, height: 43)

                                Text("D")
                                    .font(.system(size: 30, weight: .black))
                                    .foregroundColor(.white)
                            }

                            VStack(alignment: .leading, spacing: 2) {
                                Text("Hola, Dylan")
                                    .font(.headline)
                                    .foregroundColor(.black)

                                Text("Banco de Dylan")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                        }

                        Spacer()

                        Button {
                            mostrarAviso("Notificaciones")
                        } label: {
                            Image(systemName: "bell")
                                .font(.title2)
                                .foregroundColor(morado)
                        }
                    }

                    // TARJETA DE SALDO
                    VStack(alignment: .leading, spacing: 14) {
                        HStack {
                            Text("Disponible")
                                .font(.subheadline)

                            Spacer()

                            Button {
                                mostrarSaldo.toggle()
                            } label: {
                                Image(systemName:
                                    mostrarSaldo ? "eye" : "eye.slash")
                                    .foregroundColor(.white)
                            }
                        }

                        Text(
                            mostrarSaldo
                            ? "$289.000.000"
                            : "••••••••••"
                        )
                        .font(.system(size: 34, weight: .bold))
                        .minimumScaleFactor(0.6)
                        .lineLimit(1)

                        Text("COP · SALDO DE DEMOSTRACIÓN")
                            .font(.system(size: 10, weight: .bold))

                        Divider()
                            .overlay(.white.opacity(0.3))

                        HStack {
                            Text("Mi cuenta")
                            Spacer()
                            Text("•••• 85")
                        }
                        .font(.caption)
                    }
                    .foregroundColor(.white)
                    .padding(20)
                    .background(
                        LinearGradient(
                            colors: [
                                Color(hex: "7900C9"),
                                Color(hex: "D000A9")
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 23))

                    // ACCIONES
                    VStack(alignment: .leading, spacing: 18) {
                        Text("¿Qué necesitas?")
                            .font(.headline)
                            .foregroundColor(.black)

                        HStack {
                            accion("arrow.up.right", "Enviar")
                            accion("arrow.down.left", "Recibir")
                            accion("qrcode", "Pagar")
                            accion("plus", "Recargar")
                        }
                    }
                    .padding(17)
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 22))

                    // OTRAS OPCIONES
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Tus productos")
                            .font(.headline)
                            .foregroundColor(.black)

                        HStack(spacing: 12) {
                            producto("creditcard.fill", "Tarjetas")
                            producto("wallet.pass.fill", "Bolsillos")
                        }

                        HStack(spacing: 12) {
                            producto("chart.bar.fill", "Estadísticas")
                            producto("clock.fill", "Movimientos")
                        }
                    }

                    // MOVIMIENTOS
                    VStack(alignment: .leading, spacing: 16) {
                        HStack {
                            Text("Movimientos")
                                .font(.headline)

                            Spacer()

                            Button("Ver todos") {
                                mostrarAviso("Movimientos de demostración")
                            }
                            .font(.caption)
                            .foregroundColor(morado)
                        }

                        movimiento(
                            "Compra de ejemplo",
                            "-$85.000",
                            "cart.fill",
                            false
                        )

                        Divider()

                        movimiento(
                            "Recarga de ejemplo",
                            "+$100.000",
                            "plus",
                            true
                        )

                        Divider()

                        movimiento(
                            "Transferencia de ejemplo",
                            "-$50.000",
                            "arrow.left.arrow.right",
                            false
                        )
                    }
                    .padding(17)
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 22))

                    Text("BANCO DE DYLAN · DEMO · DINERO FICTICIO")
                        .font(.system(size: 10, weight: .bold))
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                }
                .padding(16)
            }
            .background(fondo)

            // NAVEGACIÓN INFERIOR
            HStack {
                pestañaBoton("house.fill", "Inicio")
                pestañaBoton("chart.bar.fill", "Estadísticas")
                pestañaBoton("bell", "Avisos")
                pestañaBoton("person.fill", "Perfil")
            }
            .padding(.top, 12)
            .padding(.bottom, 8)
            .background(.white)
        }
        .alert("Banco de Dylan · DEMO", isPresented: $aviso) {
            Button("Aceptar", role: .cancel) { }
        } message: {
            Text(mensaje + "\n\nEsta función es una simulación.")
        }
    }

    // BOTONES DE ACCIONES
    func accion(_ icono: String, _ titulo: String) -> some View {
        Button {
            mostrarAviso(titulo)
        } label: {
            VStack(spacing: 9) {
                Image(systemName: icono)
                    .font(.system(size: 23, weight: .semibold))
                    .foregroundColor(morado)
                    .frame(width: 53, height: 53)
                    .background(Color(hex: "F1E3FC"))
                    .clipShape(Circle())

                Text(titulo)
                    .font(.system(size: 11, weight: .semibold))
                    .foregroundColor(.black)
            }
            .frame(maxWidth: .infinity)
        }
    }

    // TARJETAS DE PRODUCTOS
    func producto(_ icono: String, _ titulo: String) -> some View {
        Button {
            mostrarAviso(titulo)
        } label: {
            HStack(spacing: 12) {
                Image(systemName: icono)
                    .font(.title2)
                    .foregroundColor(morado)

                Text(titulo)
                    .font(.subheadline.weight(.semibold))
                    .foregroundColor(.black)

                Spacer()

                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
                    .font(.caption)
            }
            .padding(15)
            .frame(maxWidth: .infinity)
            .background(Color(hex: "F7F2FB"))
            .clipShape(RoundedRectangle(cornerRadius: 15))
        }
    }

    // MOVIMIENTOS
    func movimiento(
        _ titulo: String,
        _ valor: String,
        _ icono: String,
        _ positivo: Bool
    ) -> some View {
        HStack(spacing: 12) {
            Image(systemName: icono)
                .foregroundColor(morado)
                .frame(width: 42, height: 42)
                .background(Color(hex: "F1E3FC"))
                .clipShape(Circle())

            VStack(alignment: .leading, spacing: 4) {
                Text(titulo)
                    .font(.subheadline.weight(.semibold))
                    .foregroundColor(.black)

                Text("Movimiento ficticio")
                    .font(.caption)
                    .foregroundColor(.gray)
            }

            Spacer()

            Text(valor)
                .font(.subheadline.weight(.bold))
                .foregroundColor(
                    positivo ? .green : Color(hex: "D00079")
                )
        }
    }

    // NAVEGACIÓN
    func pestañaBoton(_ icono: String, _ titulo: String) -> some View {
        Button {
            pestaña = titulo
            if titulo != "Inicio" {
                mostrarAviso(titulo)
            }
        } label: {
            VStack(spacing: 5) {
                Image(systemName: icono)
                    .font(.system(size: 19))

                Text(titulo)
                    .font(.system(size: 10, weight: .medium))
            }
            .foregroundColor(
                pestaña == titulo ? morado : .gray
            )
            .frame(maxWidth: .infinity)
        }
    }

    func mostrarAviso(_ texto: String) {
        mensaje = texto
        aviso = true
    }
}
