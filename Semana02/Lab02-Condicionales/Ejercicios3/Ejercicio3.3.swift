// 3.3 — Predicciones 
// PREDICT: ¿Cuántas veces se ejecuta y qué imprime al final? 
var total = 0 
for i in 1...5 { 
    total += i 
} 
print(total) // PREDICT 6: ¿Valor? 15 ¿Cuántas iteraciones? 5 

var texto = "" 
for _ in 1...3 { 
    texto += "Hola " 
} 
print(texto) // PREDICT 7: "Hola Hola Hola " 
// ¿Para qué sirve _ en vez de i? 
// Respuesta: El guion bajo (_) es un "comodín" . Se usa cuando necesitamos repetir un bloque de código N veces, pero no nos importa ni vamos a usar el valor del índice de la iteración dentro del bucle. Swift nos pide usar _ para ahorrar memoria y mantener el código limpio.