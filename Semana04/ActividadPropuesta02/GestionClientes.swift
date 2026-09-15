import Foundation

// MARK: - Clase Base (Padre)
class Cliente {
    var codigo: String
    var direccion: String
    var fechaDeRegistro: String
    var numeroCuenta: String
    var montoMinimoApertura: Double
    
    init(codigo: String, direccion: String, fechaDeRegistro: String, numeroCuenta: String, montoMinimoApertura: Double) {
        self.codigo = codigo
        self.direccion = direccion
        self.fechaDeRegistro = fechaDeRegistro
        self.numeroCuenta = numeroCuenta
        self.montoMinimoApertura = montoMinimoApertura
    }
    
    func mostrarDatos() {
        print("📄 Código: \(codigo)")
        print("📍 Dirección: \(direccion)")
        print("🗓️ Fecha de registro: \(fechaDeRegistro)")
        print("🏦 Nº Cuenta: \(numeroCuenta)")
        print(String(format: "💰 Monto mínimo de apertura: S/ %.2f", montoMinimoApertura))
    }
}

// MARK: - Subclase Cliente Natural
class ClienteNatural: Cliente {
    var nombreCompleto: String
    var dni: String
    
    init(codigo: String, direccion: String, fechaDeRegistro: String, numeroCuenta: String, montoMinimoApertura: Double, nombreCompleto: String, dni: String) {
        self.nombreCompleto = nombreCompleto
        self.dni = dni
        super.init(codigo: codigo, direccion: direccion, fechaDeRegistro: fechaDeRegistro, numeroCuenta: numeroCuenta, montoMinimoApertura: montoMinimoApertura)
    }
    
    override func mostrarDatos() {
        print("👤 Cliente Natural:")
        print("Nombre: \(nombreCompleto)")
        print("DNI: \(dni)")
        super.mostrarDatos()
    }
}

// MARK: - Subclase Cliente Jurídico
class ClienteJuridico: Cliente {
    var razonSocial: String
    var ruc: String
    var representanteLegal: String
    
    init(codigo: String, direccion: String, fechaDeRegistro: String, numeroCuenta: String, montoMinimoApertura: Double, razonSocial: String, ruc: String, representanteLegal: String) {
        self.razonSocial = razonSocial
        self.ruc = ruc
        self.representanteLegal = representanteLegal
        super.init(codigo: codigo, direccion: direccion, fechaDeRegistro: fechaDeRegistro, numeroCuenta: numeroCuenta, montoMinimoApertura: montoMinimoApertura)
    }
    
    override func mostrarDatos() {
        print("🏢 Cliente Jurídico:")
        print("Razón Social: \(razonSocial)")
        print("RUC: \(ruc)")
        print("Representante Legal: \(representanteLegal)")
        super.mostrarDatos()
    }
}

// MARK: - Captura de Datos por Consola
func registrarClienteNatural() -> ClienteNatural {
    print("\n--- 👤 REGISTRO CLIENTE NATURAL ---")
    print("Nombre Completo: ", terminator: "")
    let nombre = readLine()?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
    
    print("DNI: ", terminator: "")
    let dni = readLine()?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
    
    print("Código (Ej. C003): ", terminator: "")
    let codigo = readLine()?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
    
    print("Dirección: ", terminator: "")
    let direccion = readLine()?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
    
    print("Monto de Apertura: ", terminator: "")
    let montoStr = readLine()?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "500.00"
    let monto = Double(montoStr) ?? 500.00
    
    return ClienteNatural(
        codigo: codigo.isEmpty ? "C003" : codigo,
        direccion: direccion.isEmpty ? "Av. San Juan 123" : direccion,
        fechaDeRegistro: "2026-09-15",
        numeroCuenta: "001-2026-000789",
        montoMinimoApertura: monto,
        nombreCompleto: nombre.isEmpty ? "Xiomara Garcia" : nombre,
        dni: dni.isEmpty ? "71403373" : dni
    )
}

func registrarClienteJuridico() -> ClienteJuridico {
    print("\n--- 🏢 REGISTRO CLIENTE JURÍDICO ---")
    print("Razón Social: ", terminator: "")
    let razon = readLine()?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
    
    print("RUC: ", terminator: "")
    let ruc = readLine()?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
    
    print("Representante Legal: ", terminator: "")
    let rep = readLine()?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
    
    print("Código (Ej. C004): ", terminator: "")
    let codigo = readLine()?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
    
    print("Dirección: ", terminator: "")
    let direccion = readLine()?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
    
    print("Monto de Apertura: ", terminator: "")
    let montoStr = readLine()?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "3000.00"
    let monto = Double(montoStr) ?? 3000.00
    
    return ClienteJuridico(
        codigo: codigo.isEmpty ? "C004" : codigo,
        direccion: direccion.isEmpty ? "Av. Industrial 500" : direccion,
        fechaDeRegistro: "2026-09-15",
        numeroCuenta: "001-2026-000999",
        montoMinimoApertura: monto,
        razonSocial: razon.isEmpty ? "Tecsup Innova SAC" : razon,
        ruc: ruc.isEmpty ? "20123456789" : ruc,
        representanteLegal: rep.isEmpty ? "Xiomara Garcia" : rep
    )
}

// MARK: - Impresión de Lista
func mostrarListaClientes(lista: [Cliente]) {
    print("\n==========================================================")
    print("              📋 FICHA GENERAL DE CLIENTES 📋             ")
    print("==========================================================")
    for (index, cliente) in lista.enumerated() {
        cliente.mostrarDatos()
        if index < lista.count - 1 {
            print("----------------------------------------------------------")
        }
    }
    print("==========================================================")
}

// MARK: - Menú Principal
func ejecutarSistemaClientes() {
    // Inicialización obligatoria con los 2 clientes base del caso
    var listaClientes: [Cliente] = [
        ClienteNatural(
            codigo: "C001",
            direccion: "Av. Lima 123",
            fechaDeRegistro: "2025-04-03",
            numeroCuenta: "001-2025-000123",
            montoMinimoApertura: 500.00,
            nombreCompleto: "Juan Pérez",
            dni: "12345678"
        ),
        ClienteJuridico(
            codigo: "C002",
            direccion: "Jr. Empresas 456",
            fechaDeRegistro: "2025-04-01",
            numeroCuenta: "001-2025-000456",
            montoMinimoApertura: 3000.00,
            razonSocial: "Soluciones SAC",
            ruc: "20123456789",
            representanteLegal: "María León"
        )
    ]
    
    var ejecutando = true
    
    while ejecutando {
        print("\n==========================================================")
        print("          🏦 SISTEMA DE GESTIÓN BANCARIA TECSUP 🏦        ")
        print("==========================================================")
        print("1. 👤 Registrar Cliente Natural")
        print("2. 🏢 Registrar Cliente Jurídico")
        print("3. 📑 Mostrar Todos los Clientes")
        print("4. 🚪 Salir")
        print("----------------------------------------------------------")
        print("Seleccione una opción (1-4): ", terminator: "")
        
        if let opcion = readLine()?.trimmingCharacters(in: .whitespacesAndNewlines) {
            switch opcion {
            case "1":
                let nuevo = registrarClienteNatural()
                listaClientes.append(nuevo)
                print("✅ Cliente Natural registrado con éxito.")
            case "2":
                let nuevo = registrarClienteJuridico()
                listaClientes.append(nuevo)
                print("✅ Cliente Jurídico registrado con éxito.")
            case "3":
                mostrarListaClientes(lista: listaClientes)
            case "4":
                print("👋 ¡Gracias por usar el sistema bancario!")
                ejecutando = false
            default:
                print("⚠️ Opción no válida. Intente nuevamente.")
            }
        }
    }
}

// MARK: - Ejecución Principal
ejecutarSistemaClientes()