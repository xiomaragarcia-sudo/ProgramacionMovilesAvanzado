//
//  ResumenView.swift
//  Compras
//
//  Created by Tecsup on 9/11/26.
//

import SwiftUI
import SwiftData

// B9 · Resumen del supervisor (Reto)
struct ResumenView: View {
    @Query private var productos: [Producto]
    @Query(sort: \Proveedor.nombre) private var proveedores: [Proveedor]

    @Query(filter: #Predicate<Compra> { $0.estado == "Aprobada" })
    private var aprobadas: [Compra]

    @Query(filter: #Predicate<Compra> { $0.estado == "Pendiente" })
    private var pendientes: [Compra]

    // ② Valor del inventario = Σ stock × costo promedio
    private var valorInventario: Double {
        productos.reduce(0) { $0 + $1.valorInventario }
    }

    // ③ Crédito fiscal = Σ IGV de compras aprobadas (R1)
    private var creditoFiscal: Double {
        aprobadas.reduce(0) { $0 + $1.igv }
    }

    // Por pagar = aprobadas a crédito sin pagar
    private var porPagar: Double {
        aprobadas.filter { $0.alCredito && !$0.pagada }.reduce(0) { $0 + $1.total }
    }

    // ④ Por aprobar: cantidad e importe
    private var importePorAprobar: Double {
        pendientes.reduce(0) { $0 + $1.total }
    }

    // ⑤ Total comprado por proveedor (de mayor a menor)
    private var totalesPorProveedor: [(nombre: String, total: Double)] {
        proveedores
            .map { (nombre: $0.nombre, total: $0.totalComprado) }
            .sorted { $0.total > $1.total }
    }

    private var maximo: Double {
        max(totalesPorProveedor.first?.total ?? 0, 1)
    }

    private let columnas = [GridItem(.flexible(), spacing: 12),
                            GridItem(.flexible(), spacing: 12)]

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 12) {
                    LazyVGrid(columns: columnas, spacing: 12) {
                        TarjetaDato(titulo: "Inventario", valor: soles(valorInventario))
                        TarjetaDato(titulo: "Crédito fiscal", valor: soles(creditoFiscal))
                        TarjetaDato(titulo: "Por pagar", valor: soles(porPagar))
                        TarjetaDato(titulo: "Por aprobar",
                                    valor: "\(pendientes.count)",
                                    detalle: soles(importePorAprobar))
                    }

                    // ⑤ Barras por proveedor
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Total comprado por proveedor")
                            .font(.caption)
                            .foregroundStyle(.secondary)

                        if totalesPorProveedor.isEmpty {
                            Text("Aún no hay proveedores.").foregroundStyle(.secondary)
                        }

                        ForEach(totalesPorProveedor, id: \.nombre) { item in
                            VStack(alignment: .leading, spacing: 4) {
                                Text("**\(item.nombre)** · \(soles(item.total))")
                                    .font(.subheadline)
                                GeometryReader { geo in
                                    ZStack(alignment: .leading) {
                                        Capsule().fill(Color(.tertiarySystemFill))
                                        Capsule().fill(Color.tema)
                                            .frame(width: geo.size.width * item.total / maximo)
                                    }
                                }
                                .frame(height: 8)
                            }
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color(.secondarySystemGroupedBackground),
                                in: RoundedRectangle(cornerRadius: 16))
                }
                .padding()
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("Resumen")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) { AvatarMenu() }   // ① Avatar
            }
        }
    }
}

// Tarjeta pequeña con título y valor
struct TarjetaDato: View {
    let titulo: String
    let valor: String
    var detalle: String? = nil

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(titulo).font(.caption).foregroundStyle(.secondary)
            HStack(alignment: .firstTextBaseline, spacing: 6) {
                Text(valor)
                    .font(.title3.bold())
                    .lineLimit(1)
                    .minimumScaleFactor(0.6)
                if let detalle {
                    Text(detalle)
                        .font(.caption.bold())
                        .foregroundStyle(.orange)
                        .lineLimit(1)
                        .minimumScaleFactor(0.6)
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(.secondarySystemGroupedBackground),
                    in: RoundedRectangle(cornerRadius: 16))
    }
}
