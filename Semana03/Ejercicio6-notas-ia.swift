// Desarrollado por: xiomara garcia
import Foundation // Importa el framework Foundation para funciones básicas
var notasAlumnos: [String: [Double]] = [:] // Declaración del diccionario principal que almacena nombres como claves y arreglos de notas como valores
print("¿Cuántos alumnos registrará?") // Muestra un mensaje pidiendo la cantidad total de alumnos
let cantidadAlumnos = Int(readLine() ?? "") ?? 0 // Lee la entrada del usuario y la convierte a un número entero con valor predeterminado 0
if cantidadAlumnos > 0 { // Verifica que la cantidad ingresada sea mayor a cero
    for i in 1...cantidadAlumnos { // Bucle para iterar la cantidad de alumnos especificada
        print("\nNombre del alumno \(i):") // Muestra el encabezado para el alumno actual
        let nombre = readLine() ?? "" // Lee el nombre del alumno ingresado por teclado
        var notas: [Double] = [] // Inicializa un arreglo vacío para guardar las 3 notas del alumno
        for j in 1...3 { // Bucle secundario para pedir las 3 notas de cada alumno
            print("Ingrese la nota \(j):") // Solicita el ingreso de la nota correspondiente
            let nota = Double(readLine() ?? "") ?? 0.0 // Convierte la nota ingresada a número decimal Double
            notas.append(nota) // Agrega la nota ingresada al arreglo de notas
        } // Fin del bucle interno de notas
        notasAlumnos[nombre] = notas // Guarda en el diccionario la lista de notas asignada al nombre del alumno
    } // Fin del bucle principal de alumnos
} // Fin del bloque de validación
var promedios: [(nombre: String, promedio: Double, estado: String)] = [] // Arreglo de tuplas para almacenar el reporte calculado de cada alumno
var sumaGeneral = 0.0 // Variable para acumular la suma de todos los promedios
var notaMasAlta = 0.0 // Variable para rastrear la nota más alta encontrada
var notaMasBaja = 20.0 // Variable para rastrear la nota más baja encontrada
var aprobados = 0 // Contador de alumnos aprobados
for (nombre, notas) in notasAlumnos { // Recorre cada par clave-valor del diccionario
    let sumaNotas = notas.reduce(0, +) // Calcula la suma total de las 3 notas del alumno actual
    let promedio = sumaNotas / Double(notas.count) // Divide la suma entre la cantidad de notas para obtener el promedio
    sumaGeneral += promedio // Acumula el promedio en la suma general del grupo
    for nota in notas { // Recorre cada nota individual para hallar extremos
        if nota > notaMasAlta { notaMasAlta = nota } // Actualiza la nota más alta si la nota actual es mayor
        if nota < notaMasBaja { notaMasBaja = nota } // Actualiza la nota más baja si la nota actual es menor
    } // Fin de revisión de notas individuales
    let estado: String // Declaración de la variable para el estado académico
    switch promedio { // Estructura de control para clasificar según el promedio obtenido
    case 16.0...20.0: // Rango para rendimiento excelente
        estado = "Excelente" // Asigna el estado Excelente
    case 13.0..<16.0: // Rango para rendimiento bueno
        estado = "Bueno" // Asigna el estado Bueno
    case 10.5..<13.0: // Rango para rendimiento aprobado
        estado = "Aprobado" // Asigna el estado Aprobado
    default: // Caso por defecto para promedios menores a 10.5
        estado = "Desaprobado" // Asigna el estado Desaprobado
    } // Fin del bloque switch
    if promedio >= 10.5 { aprobados += 1 } // Incrementa el contador si el alumno está aprobado
    promedios.append((nombre: nombre, promedio: promedio, estado: estado)) // Añade los datos calculados al arreglo de promedios
} // Fin del recorrido del diccionario
promedios.sort { $0.promedio > $1.promedio } // Ordena el arreglo de promedios de mayor a menor
print("\n===== REPORTE ORDENADO POR PROMEDIO =====") // Imprime encabezado del reporte ordenado
for registro in promedios { // Recorre la lista de promedios ya ordenada
    print("Alumno: \(registro.nombre) | Promedio: \(registro.promedio) | Estado: \(registro.estado)") // Muestra datos formateados
} // Fin del bucle del reporte
print("\n===== ESTADÍSTICAS GENERALES =====") // Imprime encabezado de estadísticas
let promedioGeneral = cantidadAlumnos > 0 ? sumaGeneral / Double(cantidadAlumnos) : 0.0 // Calcula el promedio general del grupo
print("Promedio General: \(promedioGeneral)") // Muestra el promedio general calculado
print("Nota más alta: \(notaMasAlta)") // Muestra la nota máxima registrada
print("Nota más baja: \(notaMasBaja)") // Muestra la nota mínima registrada
let porcentajeAprobados = cantidadAlumnos > 0 ? (Double(aprobados) / Double(cantidadAlumnos)) * 100.0 : 0.0 // Calcula el porcentaje de aprobados
print("Porcentaje de aprobados: \(porcentajeAprobados)%") // Muestra el porcentaje de alumnos aprobados