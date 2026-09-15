// ====== CASO 1.5: HERENCIA Y POLIMORFISMO — LA CADENA DE SUCURSALES =====
// Docente: Juan León

enum CategoriaElectro {
    case lineaBlanca, tecnologia, pequenos
}

struct Electrodomestico {
    let nombre: String
    let marca: String
    let precioLista: Double
    let categoria: CategoriaElectro
}

// --- Ejemplo (ya resuelto): la base define el FLUJO; las hijas cambiaran las REGLAS ---
class Sucursal {
    let nombre: String
    let ciudad: String
    
    init(nombre: String, ciudad: String) {
        self.nombre = nombre
        self.ciudad = ciudad
    }
    
    func descuento() -> Double {
        return 0.05
    }
    
    func costoEnvio(monto: Double) -> Double {
        return 30.0
    }
    
    // REGLA 2: este metodo NO se sobreescribe en las subclases
    func cotizar(item: Electrodomestico) {
        let precioConDescuento = item.precioLista * (1 - descuento())
        let envio = costoEnvio(monto: precioConDescuento)
        let total = precioConDescuento + envio
        print("\(nombre): \(item.nombre) -> S/ \(precioConDescuento) + envio S/ \(envio) = S/ \(total)")
    }
}

// --- TODO 14: SucursalLima ---
class SucursalLima: Sucursal {
    override func descuento() -> Double {
        return 0.10
    }
    
    override func costoEnvio(monto: Double) -> Double {
        if monto >= 1500 {
            return 0.0
        } else {
            return 30.0
        }
    }
}

// --- TODO 15: SucursalProvincia ---
class SucursalProvincia: Sucursal {
    // NO sobreescribas descuento() (hereda el 5% de la base)
    
    override func costoEnvio(monto: Double) -> Double {
        let calculado = monto * 0.08
        if calculado < 50.0 {
            return 50.0
        } else {
            return calculado
        }
    }
}

// --- TODO 16: SucursalOutlet ---
class SucursalOutlet: Sucursal {
    override func descuento() -> Double {
        return 0.25
    }
    
    override func costoEnvio(monto: Double) -> Double {
        return 0.0
    }
}

// --- TODO 18: Clase nueva para prueba de polimorfismo (REGLA 6) ---
class SucursalOnline: Sucursal {
    override func costoEnvio(monto: Double) -> Double {
        return 15.0
    }
}
// RESPUESTA TODO 18: Se necesitaron 5 lineas nuevas para crear la clase SucursalOnline.

// --- TODO 17: El recorrido polimorfico (REGLA 4) ---
let refrigeradora = Electrodomestico(nombre: "Refrigeradora", marca: "Frost", precioLista: 2000.0, categoria: .lineaBlanca)
let licuadora = Electrodomestico(nombre: "Licuadora", marca: "Mix", precioLista: 250.0, categoria: .pequenos)

let sucursales: [Sucursal] = [
    SucursalLima(nombre: "Lima Centro", ciudad: "Lima"),
    SucursalProvincia(nombre: "Provincia Cusco", ciudad: "Cusco"),
    SucursalOutlet(nombre: "Outlet Ate", ciudad: "Lima")
    // Para el TODO 18 solo agregas: , SucursalOnline(nombre: "Tienda Online", ciudad: "Digital")
]

print("===== Refrigeradora (S/ 2000.0) =====")
for sucursal in sucursales {
    sucursal.cotizar(item: refrigeradora)
}

print("===== Licuadora (S/ 250.0) =====")
for sucursal in sucursales {
    sucursal.cotizar(item: licuadora)
}


// ====== FIX: Este codigo tiene 2 errores ======

// FIX 7: Falta la palabra clave 'override' porque esta modificando un metodo heredado de Sucursal.
class SucursalMall: Sucursal {
    override func descuento() -> Double {
        return 0.12
    }
}

// FIX 8: Al heredar de Sucursal, debe llamar a super.init(...) para inicializar 'nombre' y 'ciudad'.
class SucursalExpress: Sucursal {
    let radioKm: Int
    
    init(nombre: String, ciudad: String, radioKm: Int) {
        self.radioKm = radioKm
        super.init(nombre: nombre, ciudad: ciudad) // Linea que faltaba
    }
}


// ====== PREDICT: Que imprime? ======

let misteriosa: Sucursal = SucursalLima(nombre: "Lima Centro", ciudad: "Lima")

// PREDICT 6: Imprime 0.1
// Justificacion: Aunque la variable sea de tipo 'Sucursal', en tiempo de ejecucion el objeto real es 'SucursalLima', por lo que el polimorfismo ejecuta el metodo sobreescrito (10%).

// PREDICT 7: Imprime 0.0
// Justificacion: El monto con descuento es 1800.0 (2000 * 0.9). Como 1800.0 >= 1500, la regla de SucursalLima establece que el envio es gratis (0.0).