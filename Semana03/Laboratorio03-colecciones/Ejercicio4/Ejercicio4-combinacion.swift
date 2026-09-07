// Desarrollado por: xiomara garcia

import Foundation

// Pide N productos con nombre, precio y stock
// Calcula valor total y muestra stock bajo
var precios: [String: Double] = [:]
var stocks: [String: Int] = [:]

print("¿Cuántos productos?")
let n = Int(readLine() ?? "") ?? 0

if n > 0 {
    for i in 1...n {
        print("\nProducto \(i) - Nombre:")
        let nombre = readLine() ?? ""
        print("Precio:")
        let precio = Double(readLine() ?? "") ?? 0
        print("Stock:")
        let stock = Int(readLine() ?? "") ?? 0
        
        precios[nombre] = precio
        stocks[nombre] = stock
    }
}

// TODO: Calcular valor total (precio × stock)
var valorTotalInventario: Double = 0.0

for (nombre, precio) in precios {
    if let stock = stocks[nombre] {
        valorTotalInventario += precio * Double(stock)
    }
}

print("\n===== REPORTE DE INVENTARIO =====")
print("Valor total del inventario: S/. \(valorTotalInventario)")

// TODO: Mostrar productos con stock < 5
print("\n===== PRODUCTOS CON STOCK BAJO (< 5) =====")
var hayStockBajo = false
for (nombre, stock) in stocks {
    if stock < 5 {
        if let precio = precios[nombre] {
            print("- \(nombre): \(stock) unidades (S/. \(precio) c/u)")
        }
        hayStockBajo = true
    }
}

if !hayStockBajo {
    print("No hay productos con stock bajo.")
}