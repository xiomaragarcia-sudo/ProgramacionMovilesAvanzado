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

// MARK: - Datos de Prueba
let estudianteXiomara = Estudiante(
    nombre: "Xiomara Garcia",
    dni: "71403373",
    esAlumnoTecsup: true
)

let listaCursosXiomara: [Curso] = [
    Curso(nombre: "Programación en Móviles Avanzado", cantidad: 1, precioUnitario: 450.00),
    Curso(nombre: "Desarrollo de Soluciones en la Nube", cantidad: 1, precioUnitario: 550.00),
    Curso(nombre: "Integración de Sistemas Empresariales", cantidad: 1, precioUnitario: 500.00),
    Curso(nombre: "Aplicaciones Móviles Multiplataforma", cantidad: 2, precioUnitario: 480.00)
]

// MARK: - Lógica de Negocio y Cálculos
func calcularDetallesFactura(estudiante: Estudiante, cursos: [Curso]) -> (
    totalCursos: Int,
    subtotal: Double,
    igv: Double,
    totalConIGV: Double,
    descuentoCantidad: Double,
    descuentoTecsup: Double,
    totalFinal: Double
) {
    var totalCursos = 0
    var subtotal = 0.0
    
    for curso in cursos {
        totalCursos += curso.cantidad
        subtotal += curso.subtotalCurso
    }
    
    let igv = subtotal * 0.18
    let totalConIGV = subtotal + igv
    
    let aplicaDescuentoCantidad = totalCursos >= 3
    let descuentoCantidad = aplicaDescuentoCantidad ? (totalConIGV * 0.10) : 0.0
    
    let aplicaDescuentoTecsup = estudiante.esAlumnoTecsup && totalCursos >= 3
    let descuentoTecsup = aplicaDescuentoTecsup ? 400.00 : 0.0
    
    let totalFinal = totalConIGV - descuentoCantidad - descuentoTecsup
    
    return (totalCursos, subtotal, igv, totalConIGV, descuentoCantidad, descuentoTecsup, totalFinal)
}