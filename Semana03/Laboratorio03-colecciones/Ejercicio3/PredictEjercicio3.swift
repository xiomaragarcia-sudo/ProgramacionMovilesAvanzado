// Desarrollado por: xiomara garcia
// ===== PREDICT: Ejercicio 3 (Sets) =====

import Foundation

let a: Set = [1, 2, 3, 4, 5]
let b: Set = [4, 5, 6, 7, 8]

print(a.intersection(b))   // PREDICT 5: [4, 5] (elementos compartidos)
print(a.union(b).count)    // PREDICT 6: 8 (total de elementos únicos entre ambos)
print(a.subtracting(b))   // PREDICT 7: [1, 2, 3] (elementos de 'a' que no están en 'b')

var repetidos: Set = ["A", "B", "A", "C", "B"]
print(repetidos.count)     // PREDICT 8: 3 (los Sets eliminan duplicados, quedan "A", "B", "C")