
import SwiftUI

@main
struct BancoDeDylanApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

extension Color {
    init(hex: String) {
        let value = UInt64(hex, radix: 16) ?? 0
        self.init(
            red: Double((value >> 16) & 255) / 255,
            green: Double((value >> 8) & 255) / 255,
            blue: Double(value & 255) / 255
        )
    }
}

let morado = Color(hex: "7100B9")
let rosado = Color(hex: "D000A9")
let fondo = Color(hex: "F6F1FA")

// MARK: APP

struct ContentView: View {
    @State private var entro = false

    var body: some View {
        Group {
            if entro {
                MenuPrincipal()
            } else {
                PantallaInicio {
                    withAnimation {
                        entro = true
                    }
                }
            }
        }
        .preferredColorScheme(.light)
    }
}

// MARK: LOGO

struct LogoDylan: View {
    var body: some View {
        ZStack {
            Circle()
                .fill(.white)
                .frame(width: 110, height: 110)

            Text("D")
                .font(.system(size: 76, weight: .black))
                .foregroundStyle(
                    LinearGradient(
                        colors: [morado, rosado],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )

            Capsule()
                .fill(rosado)
                .frame(width: 60, height: 12)
                .rotationEffect(.degrees(-35))
                .offset(x: 22, y: -32)
        }
    }
}

// MARK: LOGIN

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

            VStack(spacing: 22) {
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
                                colors: [rosado, morado],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 18))
                }

                Text("DEMO · DINERO FICTICIO")
                    .font(.system(size: 10, weight: .bold))
                    .tracking(2)
                    .foregroundColor(.white.opacity(0.8))

                Text("Hecho por Dylan Mendez, tu hijo :)")
                    .font(.system(size: 11, weight: .medium))
                    .foregroundColor(.white.opacity(0.8))

                Spacer()
            }
            .padding(.horizontal, 32)
        }
    }
}

// MARK: MENU PRINCIPAL

struct MenuPrincipal: View {
    @State private var mostrarSaldo = true
    @State private var pestaña = "Inicio"
    @State private var pantalla: String? = nil

    var body: some View {
        VStack(spacing: 0) {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 20) {

                    encabezado

                    tarjetaSaldo

                    seccionAcciones

                    seccionProductos

                    movimientos

                    Text("Hecho por Dylan Mendez, tu hijo :)")
                        .font(.system(size: 11, weight: .medium))
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity)
                        .padding(.top, 8)

                    Text("DEMO · DINERO FICTICIO · SIN OPERACIONES REALES")
                        .font(.system(size: 9, weight: .bold))
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity)
                        .padding(.bottom, 15)
                }
                .padding(16)
            }
            .background(fondo)

            barraInferior
        }
        .sheet(item: Binding(
            get: {
                pantalla.map { PantallaItem(nombre: $0) }
            },
            set: {
                pantalla = $0?.nombre
            }
        )) { item in
            PantallaDetalle(nombre: item.nombre)
                .presentationDetents([.medium, .large])
        }
    }

    // ENCABEZADO

    var encabezado: some View {
        HStack(spacing: 10) {
            ZStack {
                Circle()
                    .fill(morado)
                    .frame(width: 45, height: 45)

                Text("D")
                    .font(.system(size: 30, weight: .black))
                    .foregroundColor(.white)
            }

            VStack(alignment: .leading, spacing: 3) {
                Text("Hola, Dylan")
                    .font(.headline)
                    .foregroundColor(.black)

                Text("Banco de Dylan Oficial")
                    .font(.caption)
                    .foregroundColor(.gray)
            }

            Spacer()

            Button {
                abrir("Notificaciones")
            } label: {
                Image(systemName: "bell")
                    .font(.title2)
                    .foregroundColor(morado)
            }
        }
    }

    // SALDO

    var tarjetaSaldo: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack {
                Text("Disponible")
                    .font(.subheadline)

                Spacer()

                Button {
                    mostrarSaldo.toggle()
                } label: {
                    Image(systemName: mostrarSaldo ? "eye" : "eye.slash")
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
                Text("Cuenta de papá")
                Spacer()
                Text("•••• 85")
            }
            .font(.caption)
        }
        .foregroundColor(.white)
        .padding(20)
        .background(
            LinearGradient(
                colors: [Color(hex: "7900C9"), rosado],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .clipShape(RoundedRectangle(cornerRadius: 23))
    }

    // ACCIONES

    var seccionAcciones: some View {
        VStack(alignment: .leading, spacing: 17) {
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
    }

    func accion(_ icono: String, _ titulo: String) -> some View {
        Button {
            abrir(titulo)
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

    // PRODUCTOS

    var seccionProductos: some View {
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
    }

    func producto(_ icono: String, _ titulo: String) -> some View {
        Button {
            abrir(titulo)
        } label: {
            HStack(spacing: 10) {
                Image(systemName: icono)
                    .font(.title2)
                    .foregroundColor(morado)

                Text(titulo)
                    .font(.subheadline.weight(.semibold))
                    .foregroundColor(.black)

                Spacer(minLength: 0)

                Image(systemName: "chevron.right")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .padding(14)
            .frame(maxWidth: .infinity)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 15))
        }
    }

    // MOVIMIENTOS

    var movimientos: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Movimientos")
                    .font(.headline)

                Spacer()

                Button("Ver todos") {
                    abrir("Movimientos")
                }
                .font(.caption)
                .foregroundColor(morado)
            }

            filaMovimiento(
                "Compra de ejemplo",
                "-$85.000",
                "cart.fill",
                false
            )

            Divider()

            filaMovimiento(
                "Recarga de ejemplo",
                "+$100.000",
                "plus",
                true
            )

            Divider()

            filaMovimiento(
                "Transferencia de ejemplo",
                "-$50.000",
                "arrow.left.arrow.right",
                false
            )
        }
        .padding(17)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 22))
    }

    func filaMovimiento(
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
                    positivo ? .green : rosado
                )
        }
    }

    // BARRA INFERIOR

    var barraInferior: some View {
        HStack {
            botonPestaña("house.fill", "Inicio")
            botonPestaña("chart.bar.fill", "Estadísticas")
            botonPestaña("bell", "Avisos")
            botonPestaña("person.fill", "Perfil")
        }
        .padding(.top, 12)
        .padding(.bottom, 8)
        .background(.white)
    }

    func botonPestaña(_ icono: String, _ titulo: String) -> some View {
        Button {
            pestaña = titulo
            if titulo != "Inicio" {
                abrir(titulo)
            }
        } label: {
            VStack(spacing: 5) {
                Image(systemName: icono)
                    .font(.system(size: 19))

                Text(titulo)
                    .font(.system(size: 10, weight: .medium))
            }
            .foregroundColor(pestaña == titulo ? morado : .gray)
            .frame(maxWidth: .infinity)
        }
    }

    func abrir(_ nombre: String) {
        pantalla = nombre
    }
}

// MARK: PANTALLAS DE OPCIONES

struct PantallaItem: Identifiable {
    let id = UUID()
    let nombre: String
}

struct PantallaDetalle: View {
    let nombre: String
    @Environment(\.dismiss) var cerrar

    var descripcion: String {
        switch nombre {
        case "Enviar":
            return "Simulación de envío de dinero."
        case "Recibir":
            return "Esta pantalla muestra información ficticia para recibir."
        case "Pagar":
            return "Zona de pagos de demostración."
        case "Recargar":
            return "Simulación de recarga."
        case "Tarjetas":
            return "Tus tarjetas de demostración aparecerán aquí."
        case "Bolsillos":
            return "Organiza tus bolsillos ficticios."
        case "Estadísticas":
            return "Aquí aparecerán estadísticas de ejemplo."
        case "Movimientos":
            return "Aquí aparecen tus movimientos ficticios."
        case "Notificaciones", "Avisos":
            return "No tienes notificaciones de demostración nuevas."
        case "Perfil":
            return "Perfil de la cuenta de papá."
        default:
            return "Sección de demostración."
        }
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Image(systemName: "sparkles")
                    .font(.system(size: 48))
                    .foregroundColor(morado)

                Text(nombre)
                    .font(.title2.bold())

                Text(descripcion)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.secondary)

                Text("DEMO · DINERO FICTICIO")
                    .font(.caption.bold())
                    .foregroundColor(morado)

                Spacer()
            }
            .padding(30)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(fondo)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Cerrar") {
                        cerrar()
                    }
                }
            }
        }
    }
}
