import Foundation

// MARK: - Modelos de Datos
struct Curso {
    let nombre: String
    let cantidad: Int
    let precioUnitario: Double
    
    var subtotalCurso: Double {
        return Double(cantidad) * precioUnitario
    }
}

struct Estudiante {
    let nombre: String
    let dni: String
    let esAlumnoTecsup: Bool
}