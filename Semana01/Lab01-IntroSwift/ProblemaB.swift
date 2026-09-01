// ===== PROBLEMA B: CONVERSOR DE MONEDAS =====
let tcDolar = 3.75    // Tipo de cambio: 1 dólar equivale a 3.75 soles
let tcEuro = 4.10     // Tipo de cambio: 1 euro equivale a 4.10 soles
let tcPesoMX = 0.22   // Tipo de cambio: 1 peso mexicano equivale a 0.22 soles

let monto1 = 100.0    // Primer monto en soles a convertir
let monto2 = 500.0    // Segundo monto en soles a convertir
let monto3 = 1000.0   // Tercer monto en soles a convertir

// Función que recibe un monto en soles e imprime su conversión a las 3 monedas
func convertirMonto(_ soles: Double) {
    let dolares = soles / tcDolar        // Convierte soles a dólares dividiendo entre el tipo de cambio
    let euros = soles / tcEuro           // Convierte soles a euros dividiendo entre el tipo de cambio
    let pesosMX = soles / tcPesoMX       // Convierte soles a pesos mexicanos dividiendo entre el tipo de cambio
    print("S/. \(soles) → $\(dolares) USD | €\(euros) EUR | $\(pesosMX) MXN")  // Imprime la fila formateada
}

// Imprime la tabla de conversión para los 3 montos
print("========== CONVERSOR DE MONEDAS ==========")   // Encabezado de la tabla
convertirMonto(monto1)                                  // Convierte y muestra el primer monto
convertirMonto(monto2)                                  // Convierte y muestra el segundo monto
convertirMonto(monto3)                                  // Convierte y muestra el tercer monto
print("===========================================")   // Cierre de la tabla