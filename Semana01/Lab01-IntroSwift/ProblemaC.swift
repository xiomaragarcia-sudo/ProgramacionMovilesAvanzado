// ===== PROBLEMA C: NOTAS DEL CURSO =====
// Estructura simple para guardar los datos de cada alumno
struct Alumno {
    let nombre: String   // Nombre del alumno
    let pa: Double        // Nota de la práctica A
    let pb: Double        // Nota de la práctica B
}

// Lista con los 5 alumnos y sus notas
let alumnos = [
    Alumno(nombre: "Xiomara", pa: 15.0, pb: 13.0),   // Alumno 1
    Alumno(nombre: "Carlos", pa: 10.0, pb: 12.0),    // Alumno 2
    Alumno(nombre: "Ana", pa: 18.0, pb: 16.0),       // Alumno 3
    Alumno(nombre: "Luis", pa: 8.0, pb: 9.0),        // Alumno 4
    Alumno(nombre: "María", pa: 14.0, pb: 15.0)      // Alumno 5
]

var sumaNotas = 0.0   // Acumulador para sumar todas las notas finales

print("========== NOTAS DEL CURSO ==========")                          // Encabezado de la tabla
for alumno in alumnos {                                                  // Recorre cada alumno de la lista
    let notaFinal = (0.30 * alumno.pa) + (0.70 * alumno.pb)              // Calcula la nota final con la fórmula del sílabo
    let estado = notaFinal >= 13.0 ? "Aprobado" : "Desaprobado"          // Define el estado según si aprueba o no
    sumaNotas += notaFinal                                               // Suma la nota final al acumulador general
    print("\(alumno.nombre): Pa=\(alumno.pa), Pb=\(alumno.pb), Final=\(notaFinal) — \(estado)")  // Imprime la fila del alumno
}
let promedioClase = sumaNotas / Double(alumnos.count)    // Calcula el promedio general dividiendo la suma entre la cantidad de alumnos
print("--------------------------------------")           // Línea divisoria
print("Promedio general de la clase: \(promedioClase)")   // Imprime el promedio general
print("=======================================")          // Cierre de la tabla