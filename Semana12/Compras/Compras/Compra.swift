//
//  Compra.swift
//  Compras
//
//  Created by Tecsup on 9/11/26.
//

import Foundation
import SwiftData

@Model
final class Compra {
    var fecha: Date
    var cantidad: Int
    var costoUnitario: Double
    var igv: Double
    var total: Double
    var alCredito: Bool
    var vence: Date
    var estado: String           // "Pendiente", "Aprobada" o "Rechazada"
    var pagada: Bool
    var motivoRechazo: String?

    // ★ Kardex: se llenan al aprobar
    var stockDespues: Int?
    var costoPromedioDespues: Double?

    // Lado "muchos": opcionales y sin @Relationship
    // (el inverse ya está declarado en Usuario, Proveedor y Producto)
    var comprador: Usuario?
    var proveedor: Proveedor?
    var producto: Producto?

    static let tasaIGV = 0.18
    static let montoAprobacion = 5000.0

    init(cantidad: Int, costoUnitario: Double, alCredito: Bool,
         comprador: Usuario?, proveedor: Proveedor?, producto: Producto?,
         fecha: Date = .now) {
        let subtotal = Double(cantidad) * costoUnitario
        let igvCalculado = Compra.redondear(subtotal * Compra.tasaIGV)   // R1

        self.fecha = fecha
        self.cantidad = cantidad
        self.costoUnitario = costoUnitario
        self.igv = igvCalculado
        self.total = Compra.redondear(subtotal + igvCalculado)
        self.alCredito = alCredito
        // R4: crédito vence a los 30 días; contado queda pagada
        self.vence = alCredito
            ? Calendar.current.date(byAdding: .day, value: 30, to: fecha) ?? fecha
            : fecha
        self.pagada = !alCredito
        self.estado = "Pendiente"   // la regla de aprobación se aplica al registrar (B5)
        self.comprador = comprador
        self.proveedor = proveedor
        self.producto = producto
    }

    var subtotal: Double { Double(cantidad) * costoUnitario }

    // R2: desde S/ 5,000 necesita aprobación del supervisor
    var requiereAprobacion: Bool { total >= Compra.montoAprobacion }

    // R4: VENCIDA = a crédito, aprobada, sin pagar y con fecha pasada
    var estaVencida: Bool {
        alCredito && estado == "Aprobada" && !pagada && vence < .now
    }

    // 1200 × 0.18 = 216.00000000000003 -> 216.00
    static func redondear(_ valor: Double) -> Double {
        (valor * 100).rounded() / 100
    }
}
