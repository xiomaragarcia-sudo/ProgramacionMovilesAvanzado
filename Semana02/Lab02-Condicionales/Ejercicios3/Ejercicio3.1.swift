// ===== EJERCICIO 3: FOR-IN ===== 
// --- Ejemplo (ya resuelto): --- 
// Imprime los números del 1 al 5: 
for i in 1...5 { 
    print("Número: \(i)") 
} 

// --- TODO 7: Tabla de multiplicar del 7 --- 
// Imprime: 7 x 1 = 7, 7 x 2 = 14, ... 7 x 12 = 84 
for i in 1...12 { 
    print("7 x \(i) = \(7 * i)") 
} 

// --- TODO 8: Sumatoria del 1 al 100 --- 
// Suma todos los números del 1 al 100 
var suma = 0 
for i in 1...100 { 
    suma = suma + i 
} 
print("La suma del 1 al 100 es: \(suma)") // Debe dar 5050 

// --- TODO 9: Calcular el factorial de 8 --- 
// Factorial: 8! = 8 × 7 × 6 × 5 × 4 × 3 × 2 × 1 = 40320 
var factorial = 1 
for i in 1...8 { 
    factorial = factorial * i 
} 
print("8! = \(factorial)") 

// --- TODO 10: Patrón de asteriscos --- 
// Imprime este patrón usando for anidados: 
// * 
// ** 
// *** 
// **** 
// ***** 
// Pista: usa String(repeating: "*", count: i)
for i in 1...5 {
    print(String(repeating: "*", count: i))
}