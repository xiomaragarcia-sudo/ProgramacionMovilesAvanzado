import Foundation

// MARK: - Modelos de Datos
struct Curso {
    let nombre: String
    let precioUnitario: Double
}

struct ItemFactura {
    let curso: Curso
    var cantidad: Int
    
    var subtotal: Double {
        return Double(cantidad) * curso.precioUnitario
    }
}

struct Estudiante {
    let nombre: String
    let dni: String
    let esAlumnoTecsup: Bool
}