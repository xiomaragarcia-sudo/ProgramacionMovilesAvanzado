// ===== EJERCICIO 2: SWITCH ===== 
// --- Ejemplo (ya resuelto): --- 
let diaSemana = 3 
switch diaSemana { 
case 1: print("Lunes") 
case 2: print("Martes") 
case 3: print("Miércoles") 
case 4: print("Jueves") 
case 5: print("Viernes") 
case 6: print("Sábado") 
case 7: print("Domingo") 
default: print("Día inválido") 
} 

// --- TODO 4: Clasificar nota numérica a letra --- 
let nota = 16 
switch nota { 
case 18...20: print("A") 
case 15...17: print("B") 
case 13...14: print("C") 
case 11...12: print("D") 
case 0...10: print("E") 
default: print("Nota inválida") 
} 

// --- TODO 5: Calculadora simple con switch --- 
let num1 = 20.0 
let num2 = 5.0 
let operacion = "+" 
switch operacion { 
case "+": print("Resultado: \(num1 + num2)") 
case "-": print("Resultado: \(num1 - num2)") 
case "*": print("Resultado: \(num1 * num2)") 
case "/": 
    // TODO: verificar que num2 no sea 0 antes de dividir 
    if num2 != 0 {
        print("Resultado: \(num1 / num2)")
    } else {
        print("Error: No se puede dividir entre cero")
    }
default: print("Operación no válida") 
} 

// --- TODO 6: Categoría de producto por precio --- 
let precio = 350.0 
// Categorías: Económico (0-99), Medio (100-499), 
// Premium (500-999), Lujo (1000+) 
// Usa switch con rangos para clasificar
switch precio {
case 0...99:
    print("Económico")
case 100...499:
    print("Medio")
case 500...999:
    print("Premium")
case 1000...:
    print("Lujo")
default:
    print("Precio inválido o negativo")
}