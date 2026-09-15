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

// MARK: - Captura de Datos por Consola
func capturarEstudiante() -> Estudiante {
    print("==========================================================")
    print("              SISTEMA DE MATRÍCULA TECSUP              ")
    print("==========================================================")
    
    print("Ingrese Nombre del Alumno: ", terminator: "")
    let nombre = readLine() ?? "Xiomara Garcia"
    
    print("Ingrese DNI: ", terminator: "")
    let dni = readLine() ?? "71403373"
    
    print("¿Es alumno de Tecsup? (S/N): ", terminator: "")
    let rpta = readLine()?.uppercased() ?? "S"
    let esTecsup = (rpta == "S" || rpta == "SI" || rpta == "SÍ")
    
    return Estudiante(nombre: nombre.isEmpty ? "Xiomara Garcia" : nombre,
                      dni: dni.isEmpty ? "71403373" : dni,
                      esAlumnoTecsup: esTecsup)
}

// MARK: - Menú Interactivo de Cursos
func seleccionarCursos() -> [ItemFactura] {
    var itemsComprados: [ItemFactura] = []
    var continuar = true
    
    while continuar {
        print("\n==========================================================")
        print("                 CATÁLOGO DE CURSOS LIBRES               ")
        print("==========================================================")
        for (i, c) in catalogoCursos.enumerated() {
            print(String(format: "%d. %-40@ - S/ %6.2f", i + 1, c.nombre as NSString, c.precioUnitario))
        }
        print("\(catalogoCursos.count + 1).  Finalizar selección y generar factura")
        print("----------------------------------------------------------")
        print("Seleccione una opción (1-\(catalogoCursos.count + 1)): ", terminator: "")
        
        if let entrada = readLine(), let opcion = Int(entrada) {
            if opcion >= 1 && opcion <= catalogoCursos.count {
                let cursoSeleccionado = catalogoCursos[opcion - 1]
                print("Ingrese la cantidad para '\(cursoSeleccionado.nombre)': ", terminator: "")
                if let cantStr = readLine(), let cant = Int(cantStr), cant > 0 {
                    itemsComprados.append(ItemFactura(curso: cursoSeleccionado, cantidad: cant))
                    print(" ¡Curso agregado correctamente!")
                } else {
                    print(" Cantidad inválida.")
                }
            } else if opcion == catalogoCursos.count + 1 {
                if itemsComprados.isEmpty {
                    print(" Debe seleccionar al menos 1 curso antes de facturar.")
                } else {
                    continuar = false
                }
            } else {
                print(" Opción no válida.")
            }
        }
    }
    
    return itemsComprados
}