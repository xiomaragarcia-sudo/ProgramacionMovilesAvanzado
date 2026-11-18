//
//  KardexView.swift
//  Compras
//
//  Created by Tecsup on 9/11/26.
//

import SwiftUI
import SwiftData
import Charts

// B10 ★ · Kardex del producto: historial de compras aprobadas y evolución del costo promedio
struct KardexView: View {
    @Environment(\.modelContext) private var contexto
    @Environment(SesionManager.self) private var sesion
    @Bindable var producto: Producto

    private var esSupervisor: Bool { sesion.usuarioActual?.esSupervisor ?? false }

    // Compras aprobadas en el orden en que se aplicaron.
    // Como el stock solo sube al aprobar, ordenar por stockDespues da ese orden.
    private var movimientos: [Compra] {
        producto.compras
            .filter { $0.estado == "Aprobada" && $0.stockDespues != nil }
            .sorted { ($0.stockDespues ?? 0) < ($1.stockDespues ?? 0) }
    }

    // Punto inicial: cómo estaba el producto antes de la primera compra aprobada
    // (despejado de la fórmula del costo promedio ponderado)
    private var puntoInicial: (stock: Int, costo: Double)? {
        guard let primera = movimientos.first,
              let stockDespues = primera.stockDespues,
              let costoDespues = primera.costoPromedioDespues else { return nil }
        let stockAntes = stockDespues - primera.cantidad
        guard stockAntes > 0 else { return nil }
        let valorAntes = costoDespues * Double(stockDespues) - Double(primera.cantidad) * primera.costoUnitario
        return (stockAntes, Compra.redondear(valorAntes / Double(stockAntes)))
    }

    // Puntos del gráfico: Inicio, Compra 1, Compra 2...
    private var puntos: [(etiqueta: String, costo: Double)] {
        var lista: [(String, Double)] = []
        if let inicial = puntoInicial { lista.append(("Inicio", inicial.costo)) }
        for (i, compra) in movimientos.enumerated() {
            lista.append(("Compra \(i + 1)", compra.costoPromedioDespues ?? 0))
        }
        return lista
    }

    private var rangoY: ClosedRange<Double> {
        let costos = puntos.map(\.costo)
        let minimo = costos.min() ?? 0
        let maximo = costos.max() ?? 1
        return (minimo - 2)...(maximo + 2)
    }

    private var colorStock: Color {
        producto.stockBajo ? .red : (producto.stockMedio ? .orange : .green)
    }

    var body: some View {
        List {
            // Cabecera: stock, costo promedio y stock mínimo
            Section {
                HStack {
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Stock").font(.caption).foregroundStyle(.secondary)
                        Text("\(producto.stock) u.").font(.title2.bold()).foregroundStyle(colorStock)
                    }
                    Spacer()
                    VStack(alignment: .trailing, spacing: 2) {
                        Text("Costo promedio").font(.caption).foregroundStyle(.secondary)
                        Text(soles(producto.costoPromedio)).font(.title2.bold())
                    }
                }
                if producto.stockBajo {
                    Label("Stock bajo: \(producto.stock) u. (mínimo \(producto.stockMinimo))",
                          systemImage: "exclamationmark.triangle.fill")
                        .font(.subheadline.bold())
                        .foregroundStyle(.red)
                }
                // Solo el supervisor puede cambiar el stock mínimo
                if esSupervisor {
                    Stepper("Stock mínimo: \(producto.stockMinimo)",
                            value: $producto.stockMinimo, in: 0...1000)
                        .onChange(of: producto.stockMinimo) { try? contexto.save() }
                } else {
                    LabeledContent("Stock mínimo", value: "\(producto.stockMinimo) u.")
                }
            }

            // Gráfico del costo promedio
            Section("Costo promedio en el tiempo") {
                if puntos.count < 2 {
                    Text("Aún no hay compras aprobadas de este producto.")
                        .foregroundStyle(.secondary)
                } else {
                    Chart(puntos, id: \.etiqueta) { punto in
                        LineMark(x: .value("Movimiento", punto.etiqueta),
                                 y: .value("Costo", punto.costo))
                            .foregroundStyle(Color.tema)
                        PointMark(x: .value("Movimiento", punto.etiqueta),
                                  y: .value("Costo", punto.costo))
                            .foregroundStyle(Color.tema)
                            .annotation(position: .top) {
                                Text(String(format: "%.2f", punto.costo))
                                    .font(.caption2)
                                    .foregroundStyle(.secondary)
                            }
                    }
                    .chartYScale(domain: rangoY)
                    .frame(height: 200)
                    .padding(.vertical, 8)
                }
            }

            // Lista de movimientos
            Section("Movimientos (compras aprobadas)") {
                if let inicial = puntoInicial {
                    FilaKardex(titulo: "Inicio",
                               detalle: "Saldo inicial",
                               stock: inicial.stock,
                               costo: inicial.costo)
                }
                ForEach(movimientos) { compra in
                    FilaKardex(titulo: "+\(compra.cantidad) a \(soles(compra.costoUnitario))",
                               detalle: "\(compra.proveedor?.nombre ?? "Proveedor") · \(diaMes(compra.fecha))",
                               stock: compra.stockDespues ?? 0,
                               costo: compra.costoPromedioDespues ?? 0)
                }
            }
        }
        .navigationTitle(producto.nombre)
        .navigationBarTitleDisplayMode(.inline)
    }

    private func diaMes(_ fecha: Date) -> String {
        let formato = DateFormatter()
        formato.dateFormat = "dd/MM"
        return formato.string(from: fecha)
    }
}

// Fila del Kardex: qué pasó y cómo quedó el producto
struct FilaKardex: View {
    let titulo: String
    let detalle: String
    let stock: Int
    let costo: Double

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 2) {
                Text(titulo).font(.subheadline.bold())
                Text(detalle).font(.caption).foregroundStyle(.secondary)
            }
            Spacer()
            VStack(alignment: .trailing, spacing: 2) {
                Text("\(stock) u.").font(.subheadline.bold())
                Text(soles(costo)).font(.caption).foregroundStyle(.secondary)
            }
        }
    }
}
