// ====== CASO 2 – PARTE B: BIBLIOTECA (CON IA) =====
// Docente: Juan León

// TODO 20: pega aquí el código generado por la IA, ya comentado línea por línea

// Define los dos estados posibles en los que puede estar un libro
enum EstadoLibro {
    case disponible // Estado cuando el libro se puede prestar
    case prestado   // Estado cuando el libro ya fue entregado a un usuario
}

// Representa la estructura de un libro (tipo valor)
struct Libro {
    let titulo: String           // Nombre del libro que no cambia
    let autor: String            // Autor del libro
    var estado: EstadoLibro = .disponible // Estado actual del libro, inicia disponible
}

// Clase para gestionar la colección y operaciones de la biblioteca (tipo referencia)
class Biblioteca {
    var libros: [Libro] = [] // Array dinámico que almacena la lista de libros
    
    // Agrega una nueva instancia de Libro al arreglo de la biblioteca
    func agregar(libro: Libro) {
        libros.append(libro) // Añade el elemento al final del array
    }
    
    // Procesa el préstamo de un libro buscando por su título exacto
    func prestar(titulo: String) -> Bool {
        // Recorre el arreglo elemento por elemento usando su índice numérico
        for i in 0..<libros.count {
            // Compara si el título del libro actual coincide con el buscado
            if libros[i].titulo == titulo {
                // Verifica si el libro encontrado está disponible
                if libros[i].estado == .disponible {
                    libros[i].estado = .prestado // Modifica el struct directamente DENTRO del array
                    print("Préstamo aprobado: \(titulo)") // Muestra mensaje de éxito en consola
                    return true // Confirma que la operación fue exitosa
                } else {
                    print("Error: \(titulo) ya está prestado") // Informa que ya estaba ocupado
                    return false // Cancela la operación
                }
            }
        }
        print("Error: no existe \(titulo)") // Mensaje si no se encuentra el título
        return false // Retorna falso si no existía en el inventario
    }
    
    // Procesa la devolución de un libro prestado
    func devolver(titulo: String) -> Bool {
        // Recorre el arreglo de libros por su posición de índice
        for i in 0..<libros.count {
            // Revisa si el título en la posición 'i' coincide con el parámetro
            if libros[i].titulo == titulo {
                // Comprueba que el libro esté en estado prestado para poder devolverlo
                if libros[i].estado == .prestado {
                    libros[i].estado = .disponible // Cambia el estado a disponible en el arreglo
                    print("Devolución registrada: \(titulo)") // Imprime confirmación de devolución
                    return true // Finaliza la función devolviendo verdadero
                } else {
                    print("Error: \(titulo) no está prestado") // Advierte si se intentó devolver uno disponible
                    return false // Retorna falso por error de estado
                }
            }
        }
        print("Error: no existe \(titulo)") // Notifica que el libro no pertenece a la biblioteca
        return false // Retorna falso al no encontrarlo
    }
    
    // Muestra en pantalla el listado completo de libros y su estado actual
    func inventario() {
        print("====== INVENTARIO ======") // Encabezado de la sección
        // Iteración simple sobre cada objeto Libro del array
        for libro in libros {
            var estadoTexto = "" // Variable auxiliar para almacenar el texto del estado
            // Evalúa el enum del libro actual para asignar su versión en texto
            switch libro.estado {
            case .disponible:
                estadoTexto = "disponible" // Asigna la cadena correspondiente
            case .prestado:
                estadoTexto = "prestado"   // Asigna la cadena correspondiente
            }
            // Imprime los detalles del libro con el formato especificado
            print("\(libro.titulo) (\(libro.autor)) - \(estadoTexto)")
        }
    }
}

// --- Simulación de operaciones ---
let biblioteca = Biblioteca() // Instancia la clase principal de la biblioteca

// Registro de catálogo inicial de libros
biblioteca.agregar(libro: Libro(titulo: "Cien años de soledad", autor: "Gabriel García Márquez"))
biblioteca.agregar(libro: Libro(titulo: "La ciudad y los perros", autor: "Mario Vargas Llosa"))
biblioteca.agregar(libro: Libro(titulo: "El Quijote", autor: "Miguel de Cervantes"))

// Ejecución de flujo de pruebas según la guía
_ = biblioteca.prestar(titulo: "La ciudad y los perros")
_ = biblioteca.prestar(titulo: "La ciudad y los perros")
_ = biblioteca.devolver(titulo: "La ciudad y los perros")
_ = biblioteca.prestar(titulo: "El Quijote")
_ = biblioteca.prestar(titulo: "El Principito")

// Imprime el estado final del inventario
biblioteca.inventario()