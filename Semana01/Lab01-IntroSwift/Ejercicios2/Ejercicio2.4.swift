let precioProducto = 350.0
let igv = precioProducto * 0.18
let precioConIgv = precioProducto + igv
print("Precio: S/. \(precioProducto)")
print("IGV: S/. \(igv)")
print("Total: S/. \(precioConIgv)")
 
let pi = 3.14159
let radio = 5.0
let area = pi * radio * radio
print("Área: \(area)")
 
let notaPa = 15.0
let notaPb = 13.0
let notaFinal = (0.30 * notaPa) + (0.70 * notaPb)
print("Nota final: \(notaFinal)")
print("¿Aprueba? \(notaFinal >= 13.0)")
