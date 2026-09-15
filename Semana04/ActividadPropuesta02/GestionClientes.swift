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