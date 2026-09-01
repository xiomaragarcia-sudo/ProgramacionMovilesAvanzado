// ===== EJERCICIO 6: CARRITO MEJORADO (con IA) =====

// Datos base del carrito (mismos del ejercicio 5)
let prodA = "Laptop"           // Nombre del producto A
let precioA = 3500.0           // Precio unitario del producto A
let cantA = 3                  // Cantidad comprada del producto A (3+ activa descuento por cantidad)

let cuponIngresado = "DESCUENTO20"   // Cupón que el cliente ingresó
let codigoValido = "DESCUENTO20"      // Código real válido para comparar

// Validación: precio o cantidad inválidos
var hayError = false                              // Bandera para saber si hay un dato inválido
if precioA < 0 || cantA == 0 {                    // Si el precio es negativo o la cantidad es cero
    hayError = true                               // Marca que hay un error
    print("Error: precio o cantidad inválidos")   // Muestra el mensaje de error
}

if !hayError {                                     // Si no hay errores, continúa con el cálculo
    var subtotalA = precioA * Double(cantA)        // Calcula el subtotal del producto A

    // Descuento por cantidad: 5% extra si compra 3 o más unidades
    if cantA >= 3 {                                // Si la cantidad es 3 o más
        subtotalA = subtotalA * 0.95               // Aplica 5% de descuento sobre ese producto
    }

    // Cupón de descuento: 20% adicional si el código coincide
    var totalConCupon = subtotalA                  // Copia el subtotal para aplicarle el cupón
    if cuponIngresado == codigoValido {             // Si el cupón ingresado es el correcto
        totalConCupon = totalConCupon * 0.80        // Aplica 20% de descuento adicional
    }

    // Envío gratis si el total supera S/. 3000
    var costoEnvio = 25.0                           // Costo de envío por defecto
    if totalConCupon > 3000 {                       // Si el total supera 3000
        costoEnvio = 0.0                            // El envío es gratis
    }

    let totalFinal = totalConCupon + costoEnvio     // Suma el envío al total con descuentos

    // Puntos de fidelidad: 1 punto por cada S/. 100 de compra
    let puntosGanados = Int(totalFinal / 100)       // Divide el total entre 100 para obtener los puntos

    // Impresión del resumen
    print("Subtotal con descuento por cantidad: S/. \(subtotalA)")   // Muestra el subtotal ya con descuento
    print("Total con cupón aplicado: S/. \(totalConCupon)")          // Muestra el total tras el cupón
    print("Costo de envío: S/. \(costoEnvio)")                       // Muestra el costo de envío
    print("TOTAL FINAL: S/. \(totalFinal)")                          // Muestra el total final a pagar
    print("Puntos de fidelidad ganados: \(puntosGanados)")           // Muestra los puntos ganados
}