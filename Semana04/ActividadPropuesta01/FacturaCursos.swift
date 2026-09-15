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

// MARK: - Catálogo Completo de Cursos Libres
let catalogoCursos: [Curso] = [
    Curso(nombre: "Programación en Móviles Avanzado", precioUnitario: 450.00),
    Curso(nombre: "Desarrollo de Soluciones en la Nube", precioUnitario: 550.00),
    Curso(nombre: "Marketing y Comercialización", precioUnitario: 400.00),
    Curso(nombre: "Integración de Sistemas Empresariales", precioUnitario: 500.00),
    Curso(nombre: "Tutoría 5", precioUnitario: 200.00),
    Curso(nombre: "Diseño de Proyectos de Innovación", precioUnitario: 420.00),
    Curso(nombre: "Desarrollo de Aplicaciones Web", precioUnitario: 520.00),
    Curso(nombre: "Aplicaciones Móviles Multiplataforma", precioUnitario: 480.00)
]