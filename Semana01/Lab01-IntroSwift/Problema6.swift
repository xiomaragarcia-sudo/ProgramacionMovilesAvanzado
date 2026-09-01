// ===== EJERCICIO 6: CONVERSOR COMPLETO =====

// --- Conversión de Temperatura (Celsius, Fahrenheit, Kelvin) ---
let temperaturasC = [0.0, 25.0, 100.0]    // 3 temperaturas de ejemplo en grados Celsius

print("========== TEMPERATURA ==========")                     // Encabezado de la sección
for c in temperaturasC {                                        // Recorre cada temperatura en Celsius
    let f = (c * 9/5) + 32                                       // Fórmula: Celsius a Fahrenheit
    let k = c + 273.15                                           // Fórmula: Celsius a Kelvin
    print("\(c)°C = \(f)°F = \(k)K")                             // Imprime la fila con las 3 equivalencias
}

// --- Conversión de Distancia (Kilómetros, Millas, Metros) ---
let distanciasKm = [1.0, 5.0, 42.195]     // 3 distancias de ejemplo en kilómetros

print("========== DISTANCIA ==========")                        // Encabezado de la sección
for km in distanciasKm {                                         // Recorre cada distancia en kilómetros
    let millas = km * 0.621371                                   // Fórmula: kilómetros a millas
    let metros = km * 1000                                       // Fórmula: kilómetros a metros
    print("\(km) km = \(millas) millas = \(metros) m")           // Imprime la fila con las 3 equivalencias
}

// --- Conversión de Tiempo (Horas, Minutos, Segundos) ---
let horasEjemplo = [1.0, 2.5, 0.75]       // 3 duraciones de ejemplo en horas

print("========== TIEMPO ==========")                           // Encabezado de la sección
for h in horasEjemplo {                                          // Recorre cada duración en horas
    let minutos = h * 60                                         // Fórmula: horas a minutos
    let segundos = h * 3600                                      // Fórmula: horas a segundos
    print("\(h) horas = \(minutos) minutos = \(segundos) segundos")  // Imprime la fila con las 3 equivalencias
}