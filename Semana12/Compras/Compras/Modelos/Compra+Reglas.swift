//
//  Compra+Reglas.swift
//  Compras
//
//  Created by Tecsup on 9/11/26.
//

import Foundation

// Reglas de negocio de una compra (R2, R3, R5 del expediente)
extension Compra {

    // R3 · Costo promedio ponderado:
    // nuevo = (stock × costoPromedio + cantidad × costoUnitario) / (stock + cantidad)
    static func costoPromedioPonderado(stock: Int, costoPromedio: Double,
                                       cantidad: Int, costoUnitario: Double) -> Double {
        let unidades = stock + cantidad
        guard unidades > 0 else { return costoUnitario }
        let valor = Double(stock) * costoPromedio + Double(cantidad) * costoUnitario
        return redondear(valor / Double(unidades))
    }

    // Vista previa (se usa en B7): cómo quedaría el producto si se aprueba
    var stockSiSeAprueba: Int { (producto?.stock ?? 0) + cantidad }

    var costoPromedioSiSeAprueba: Double {
        guard let producto else { return costoUnitario }
        return Compra.costoPromedioPonderado(stock: producto.stock,
                                             costoPromedio: producto.costoPromedio,
                                             cantidad: cantidad,
                                             costoUnitario: costoUnitario)
    }

    // R2 · Aprobar: recién aquí cambian stock y costo promedio
    func aprobar() {
        guard let producto, estado != "Aprobada" else { return }
        let nuevoCosto = costoPromedioSiSeAprueba
        producto.stock += cantidad
        producto.costoPromedio = nuevoCosto
        // ★ Kardex: guarda cómo quedó el producto después de esta compra
        stockDespues = producto.stock
        costoPromedioDespues = nuevoCosto
        estado = "Aprobada"
        motivoRechazo = nil
    }

    // R2 · Rechazar: exige motivo y no cambia nada del producto
    @discardableResult
    func rechazar(motivo: String) -> Bool {
        let limpio = motivo.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !limpio.isEmpty, estado == "Pendiente" else { return false }
        estado = "Rechazada"
        motivoRechazo = limpio
        return true
    }

    // R5 · Pagar (solo supervisor): solo compras a crédito aprobadas
    func pagar() {
        guard alCredito, estado == "Aprobada" else { return }
        pagada = true
    }
}
