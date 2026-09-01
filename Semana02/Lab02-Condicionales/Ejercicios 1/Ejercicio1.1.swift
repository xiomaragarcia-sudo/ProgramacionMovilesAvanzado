import UIKit // (ojo – el cambio lo vimos en clase... Atento!!!!) 
//Docente : Juan León S. 

// ===== EJERCICIO 1: CONDICIONALES ===== 
// --- Ejemplo (ya resuelto): --- 
let nota = 15.0 
if nota >= 13.0 { 
    print("Aprobado con \(nota)") 
} else { 
    print("Desaprobado con \(nota)") 
} 

// --- TODO 1: Validar si una persona es mayor de edad --- 
let edad = 17 
if edad >= 18 { 
    print("Es mayor de edad") 
} else { 
    print("Es menor de edad") 
} 

// --- TODO 2: Clasificar una nota con else if --- 
let miNota = 16.0 
// Categorías: Excelente (18-20), Bueno (15-17), 
// Aprobado (13-14), Desaprobado (0-12) 
if miNota >= 18 { 
    print("Excelente") 
} else if miNota >= 15 { 
    print("Bueno") 
} else if miNota >= 13 { 
    print("Aprobado") 
} else { 
    print("Desaprobado") 
} 

// --- TODO 3: Verificar si un número es positivo, negativo o cero --- 
let numero = -5 
// Escribe la estructura if / else if / else completa
if numero > 0 {
    print("Es un número positivo")
} else if numero < 0 {
    print("Es un número negativo")
} else {
    print("El número es cero")
}