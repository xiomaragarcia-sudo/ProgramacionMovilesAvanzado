//
//  Producto.swift
//  Compras
//
//  Created by Tecsup on 9/11/26.
//

import Foundation
import SwiftData

@Model
final class Producto {
    var nombre: String
    var categoria: String
    var stock: Int
    var costoPromedio: Double    // sin IGV
    var stockMinimo: Int = 5     // ★ agregado para el Kardex

    @Relationship(deleteRule: .deny, inverse: \Compra.producto)
    var compras: [Compra] = []

    init(nombre: String, categoria: String, stock: Int,
         costoPromedio: Double, stockMinimo: Int = 5) {
        self.nombre = nombre
        self.categoria = categoria
        self.stock = stock
        self.costoPromedio = costoPromedio
        self.stockMinimo = stockMinimo
    }

    // Valor del inventario = stock × costo promedio (B3)
    var valorInventario: Double { Double(stock) * costoPromedio }

    // R8: rojo si stock <= mínimo, naranja si stock <= 2 × mínimo
    var stockBajo: Bool { stock <= stockMinimo }
    var stockMedio: Bool { !stockBajo && stock <= stockMinimo * 2 }
}
