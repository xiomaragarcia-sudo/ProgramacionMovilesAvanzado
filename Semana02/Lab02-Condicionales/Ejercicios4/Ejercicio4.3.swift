// 4.3 — Predicciones 
// PREDICT: ¿Cuántas veces se ejecuta cada bucle? 
var a = 100 
while a > 1 { 
    a = a / 3 
} 
print(a) // PREDICT 8: ¿Valor final? 1 ¿Cuántas vueltas? 4 
/* 
 Explicación paso a paso de las 4 vueltas (Swift hace división entera):
 Vuelta 1: 100 / 3 = 33
 Vuelta 2: 33 / 3 = 11
 Vuelta 3: 11 / 3 = 3
 Vuelta 4: 3 / 3 = 1 (Ahí termina porque 1 ya no es mayor que 1)
*/

var b = 0 
repeat { 
    b += 1 
} while b < 0 
print(b) // PREDICT 9: ¿Valor? 1 
// ¿Por qué repeat-while ejecuta al menos una vez? 
// Respuesta: Porque en un ciclo `repeat-while`, la condición (b < 0) se evalúa al FINAL de la vuelta. El código entra, suma 1 a "b" y recién después pregunta si debe repetir. Al ver que 1 no es menor que 0, se detiene, pero el código de adentro ya se ejecutó una vez.