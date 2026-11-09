//
//  AprobarView.swift
//  Compras
//
//  Created by Tecsup on 9/11/26.
//

import SwiftUI
import SwiftData

// B7 · Aprobar (solo Supervisor)
struct AprobarView: View {
    @Environment(\.modelContext) private var contexto

    // Solo las compras pendientes, la más antigua primero
    @Query(filter: #Predicate<Compra> { $0.estado == "Pendiente" },
           sort: \Compra.fecha)
    private var pendientes: [Compra]

    @State private var compraARechazar: Compra?
    @State private var motivo = ""
    @State private var mensaje: String?

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    ForEach(pendientes) { compra in
                        TarjetaAprobacion(compra: compra,
                                          alAprobar: { aprobar(compra) },
                                          alRechazar: {
                                              motivo = ""
                                              compraARechazar = compra
                                          })
                    }
                    if !pendientes.isEmpty {
                        Text("Al rechazar se pide un motivo, que el comprador verá en \"Mis compras\".")
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                    }
                }
                .padding()
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("Aprobar")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) { AvatarMenu() }   // ① Avatar
            }
            .overlay {
                if pendientes.isEmpty {
                    ContentUnavailableView("Nada por aprobar", systemImage: "checkmark.seal",
                        description: Text("Las compras desde S/ 5,000 aparecerán aquí."))
                }
            }
            // ④ Rechazar pide motivo; sin motivo el botón queda desactivado
            .alert("Rechazar compra",
                   isPresented: Binding(get: { compraARechazar != nil },
                                        set: { if !$0 { compraARechazar = nil } })) {
                TextField("Motivo del rechazo", text: $motivo)
                Button("Cancelar", role: .cancel) { compraARechazar = nil }
                Button("Rechazar", role: .destructive) { rechazar() }
                    .disabled(motivo.trimmingCharacters(in: .whitespaces).isEmpty)
            } message: {
                Text("Escribe el motivo. El comprador lo verá en Mis compras.")
            }
            .alert("Listo",
                   isPresented: Binding(get: { mensaje != nil },
                                        set: { if !$0 { mensaje = nil } })) {
                Button("OK", role: .cancel) {}
            } message: {
                Text(mensaje ?? "")
            }
        }
    }

    // Aprobar: aquí recién se aplican stock y costo promedio (R2, R3)
    private func aprobar(_ compra: Compra) {
        compra.aprobar()
        try? contexto.save()
        if let producto = compra.producto {
            mensaje = "Compra aprobada. \(producto.nombre): stock \(producto.stock) u. · costo promedio \(soles(producto.costoPromedio))."
        }
    }

    // Rechazar: guarda el motivo y no cambia el producto
    private func rechazar() {
        guard let compra = compraARechazar else { return }
        if compra.rechazar(motivo: motivo) {
            try? contexto.save()
            mensaje = "Compra rechazada. El stock no cambió."
        }
        compraARechazar = nil
    }
}

// ② Tarjeta de la compra pendiente con quién la solicitó y ③ vista previa del efecto
struct TarjetaAprobacion: View {
    let compra: Compra
    let alAprobar: () -> Void
    let alRechazar: () -> Void

    private func diaMes(_ fecha: Date) -> String {
        let formato = DateFormatter()
        formato.dateFormat = "dd/MM"
        return formato.string(from: fecha)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            // Encabezado
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 2) {
                    Text("\(compra.proveedor?.nombre ?? "Proveedor") · \(compra.producto?.nombre ?? "Producto")")
                        .font(.headline)
                    Text("Solicitó: \(compra.comprador?.nombre ?? "—") · \(diaMes(compra.fecha))")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                Spacer()
                Insignia(texto: "Pendiente", color: .orange)
            }

            // Detalle
            Text("\(compra.cantidad) u. × \(soles(compra.costoUnitario)) = \(soles(compra.subtotal))")
            Text("IGV 18% \(soles(compra.igv)) · **Total \(soles(compra.total))**")
            Text(compra.alCredito ? "Crédito 30 días · vence \(diaMes(compra.vence))" : "Contado")
                .foregroundStyle(.secondary)

            // ③ Vista previa: antes → después
            if let producto = compra.producto {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Si apruebas: **stock \(producto.stock) → \(compra.stockSiSeAprueba)**")
                    Text("Costo promedio **\(soles(producto.costoPromedio)) → \(soles(compra.costoPromedioSiSeAprueba))**")
                }
                .font(.subheadline)
                .padding(10)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color(.tertiarySystemFill), in: RoundedRectangle(cornerRadius: 10))
            }

            // ④ Rechazar o Aprobar
            HStack(spacing: 12) {
                Button(action: alRechazar) {
                    Text("Rechazar")
                        .font(.headline)
                        .foregroundStyle(.red)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .overlay(RoundedRectangle(cornerRadius: 14).stroke(.red, lineWidth: 1.5))
                }
                Button("Aprobar", action: alAprobar)
                    .buttonStyle(BotonPrincipal())
            }
            .padding(.top, 4)
        }
        .font(.subheadline)
        .padding()
        .background(Color(.secondarySystemGroupedBackground),
                    in: RoundedRectangle(cornerRadius: 16))
    }
}
