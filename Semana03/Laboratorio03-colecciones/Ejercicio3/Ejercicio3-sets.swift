// Desarrollado por: xiomara garcia

import Foundation

// ===== TODO 8: Eliminar duplicados =====
var numeros: [Int] = []
for i in 1...8 {
    print("Número \(i):")
    let n = Int(readLine() ?? "") ?? 0
    numeros.append(n)
}
print("Con duplicados: \(numeros)")
let sinDuplicados = Array(Set(numeros)).sorted()
print("Sin duplicados: \(sinDuplicados)")

// ===== TODO 9: Comparar asistencia =====
var lunes: Set<String> = []
print("\n===== ASISTENCIA LUNES =====")
for i in 1...4 {
    print("Alumno \(i) (Lunes):")
    let nombre = readLine() ?? ""
    lunes.insert(nombre)
}

var martes: Set<String> = []
print("\n===== ASISTENCIA MARTES =====")
for i in 1...4 {
    print("Alumno \(i) (Martes):")
    let nombre = readLine() ?? ""
    martes.insert(nombre)
}

print("\n===== RESULTADOS ASISTENCIA =====")
print("Ambos días: \(lunes.intersection(martes))")
print("Solo lunes: \(lunes.subtracting(martes))")
print("Solo martes: \(martes.subtracting(lunes))")