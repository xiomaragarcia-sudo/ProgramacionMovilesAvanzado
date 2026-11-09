// Desarrollado por: xiomara garcia
// ===== ANALYZE 1: Análisis de diccionarios =====

var edades: [String: Int] = ["Ana": 20, "Luis": 22, "María": 19]
var mayores: [String] = []

for (nombre, edad) in edades {
    if edad >= 21 {
        mayores.append(nombre)
    }
}

print("Mayores de 21: \(mayores)")

// ANALYZE 1:
// ¿Qué hace?: Filtra del diccionario a las personas con edad mayor o igual a 21 y guarda sus nombres en un nuevo arreglo.
// ¿Qué imprime?: Mayores de 21: ["Luis"]
