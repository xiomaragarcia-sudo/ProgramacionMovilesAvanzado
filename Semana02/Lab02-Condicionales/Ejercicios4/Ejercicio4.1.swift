// 4.1 — Completar while 
// ===== EJERCICIO 4: WHILE ===== 
// --- Ejemplo (ya resuelto): --- 
var contador = 5 
while contador > 0 { 
    print("Cuenta regresiva: \(contador)") 
    contador -= 1 // Resta 1 en cada vuelta 
} 
print("¡Despegue!") 

// --- TODO 11: Ahorro mensual --- 
// Un alumno ahorra S/. 150 cada mes. 
// ¿Cuántos meses necesita para juntar S/. 2000? 
var ahorro = 0.0 
var meses = 0 
let meta = 2000.0 
let ahorroMensual = 150.0 
while ahorro < meta { 
    ahorro += ahorroMensual 
    meses += 1 
} 
print("Necesita \(meses) meses para juntar S/. \(meta)") 

// --- TODO 12: División sucesiva --- 
// Divide un número entre 2 repetidamente hasta que sea menor a 1 
var numero = 1000.0 
var divisiones = 0 
while numero >= 1.0 { 
    numero = numero / 2 
    divisiones += 1 
    print("División \(divisiones): \(numero)") 
} 
print("Se dividió \(divisiones) veces")