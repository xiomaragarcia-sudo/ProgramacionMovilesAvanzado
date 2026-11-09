// 1.3 — Predicciones 
// PREDICT: ¿Qué imprime cada bloque? 
let x = 10 
if x > 5 && x < 20 { 
    print("Dentro del rango") 
} else { 
    print("Fuera del rango") 
} // PREDICT 1: "Dentro del rango" 

let y = 15 
if y > 20 { 
    print("Mayor que 20") 
} else if y > 10 { 
    print("Mayor que 10") 
} else if y > 5 { 
    print("Mayor que 5") 
} // PREDICT 2: "Mayor que 10" 
// ¿Por qué no imprime "Mayor que 5" también? 
// Respuesta: Porque en una estructura if / else if, el programa se detiene y ejecuta solo el bloque de la PRIMERA condición que resulte verdadera. Como `y > 10` se cumple primero, ignora las condiciones de abajo.

let esLunes = true 
let llueve = false 
if esLunes && llueve { 
    print("Lunes lluvioso") 
} else if esLunes || llueve { 
    print("Es lunes O llueve") 
} else { 
    print("Ni lunes ni llueve") 
} // PREDICT 3: "Es lunes O llueve"