// 4.2 — Completar repeat-while 
// --- TODO 13: Validar datos con repeat-while --- 
// Simula pedir una nota hasta que sea válida (entre 0 y 20) 
// Usamos valores fijos porque no podemos pedir input en Playground 

// let notasIngresadas = [25, -3, 15] // NO uses esto (es array, semana 3) 
// En su lugar, simula con variables: 
let intento1 = 25 // Inválido: > 20 
let intento2 = -3 // Inválido: < 0 
let intento3 = 15 // Válido 

var intentoActual = intento1 
var esValido = false 
var numIntento = 1 

repeat { 
    // TODO: Verifica si intentoActual está entre 0 y 20 
    if intentoActual >= 0 && intentoActual <= 20 { 
        esValido = true 
        print("Nota \(intentoActual) válida en intento \(numIntento)") 
    } else { 
        print("Nota \(intentoActual) inválida, intento \(numIntento)") 
        // Simula el siguiente intento: 
        if numIntento == 1 { intentoActual = intento2 } 
        if numIntento == 2 { intentoActual = intento3 } 
        numIntento += 1 
    } 
} while !esValido