// TODO 21: Redondear un Double a 2 decimales
let numeroPi = 3.14159
let piFormateado = String(format: "%.2f", numeroPi)
print("Con String format: \(piFormateado)") // 3.14
 
// TODO 22: ¿Qué hace += ?
// Es un atajo para sumar y reasignar al mismo tiempo (x = x + 5 → x += 5)
var score = 10
score += 5
print("Score actual: \(score)") // 15
