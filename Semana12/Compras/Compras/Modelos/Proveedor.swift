//
//  Proveedor.swift
//  Compras
//
//  Created by Tecsup on 9/11/26.
//

import Foundation
import SwiftData

@Model
final class Proveedor {
    var nombre: String
    var ruc: String

    @Relationship(deleteRule: .deny, inverse: \Compra.proveedor)
    var compras: [Compra] = []

    init(nombre: String, ruc: String) {
        self.nombre = nombre
        self.ruc = ruc
    }

    // Valores calculados desde sus compras (pantalla B4)
    var totalComprado: Double {
        compras.filter { $0.estado == "Aprobada" }.reduce(0) { $0 + $1.total }
    }
    var cantidadPorPagar: Int {
        compras.filter { $0.estado == "Aprobada" && !$0.pagada }.count
    }
}
