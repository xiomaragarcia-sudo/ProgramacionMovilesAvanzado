// ===== EJERCICIO 7: JUEGO DE ADIVINANZA (con IA) =====

let numeroSecreto = 42        // Número que el jugador debe adivinar

// Simulación de 5 intentos con variables fijas
let intento1 = 20             // Primer intento del jugador
let intento2 = 50             // Segundo intento
let intento3 = 35             // Tercer intento
let intento4 = 45             // Cuarto intento
let intento5 = 42             // Quinto intento (coincide con el secreto)

let intentos = [intento1, intento2, intento3, intento4, intento5]  // Lista de los 5 intentos, en orden

var indice = 0                 // Posición actual dentro de la lista de intentos
var adivino = false             // Bandera: se vuelve true si acierta

while indice < intentos.count && !adivino {   // Repite mientras haya intentos y no haya adivinado
    let actual = intentos[indice]              // Toma el intento actual de la lista

    if actual == numeroSecreto {               // Si el intento es igual al número secreto
        print("Intento \(indice + 1): ¡Correcto! El número era \(actual)")  // Muestra que acertó
        adivino = true                          // Marca que ya adivinó, para detener el bucle
    } else if actual > numeroSecreto {          // Si el intento es mayor al número secreto
        print("Intento \(indice + 1): \(actual) → Muy alto")                // Indica que se pasó
    } else {                                    // Si el intento es menor al número secreto
        print("Intento \(indice + 1): \(actual) → Muy bajo")                // Indica que le faltó
    }

    indice += 1                                 // Avanza al siguiente intento
}

if !adivino {                                   // Si terminó el bucle sin adivinar
    print("Perdiste. El número era: \(numeroSecreto)")   // Muestra el número que no se adivinó
} else {
    print("Adivinado en \(indice) intento(s)")   // Muestra cuántos intentos necesitó
}