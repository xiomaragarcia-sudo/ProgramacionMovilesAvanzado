//
//  ProductoFormView.swift
//  Compras
//
//  Created by Tecsup on 9/11/26.
//

import SwiftUI
import SwiftData

// Formulario para crear (producto == nil) o editar un producto. Solo lo abre el supervisor.
struct ProductoFormView: View {
    @Environment(\.modelContext) private var contexto
    @Environment(\.dismiss) private var dismiss

    let producto: Producto?

    @State private var nombre = ""
    @State private var categoria = ""
    @State private var stockTexto = ""
    @State private var costoTexto = ""
    @State private var stockMinimo = 5

    // Si ya tiene compras, el stock y el costo solo cambian con compras aprobadas
    private var tieneCompras: Bool { !(producto?.compras.isEmpty ?? true) }

    private var stock: Int? { Int(stockTexto) }
    private var costo: Double? { Double(costoTexto.replacingOccurrences(of: ",", with: ".")) }

    private var valido: Bool {
        !nombre.trimmingCharacters(in: .whitespaces).isEmpty
        && !categoria.trimmingCharacters(in: .whitespaces).isEmpty
        && (stock ?? -1) >= 0 && (costo ?? -1) >= 0
    }

    var body: some View {
        NavigationStack {
            Form {
                Section("Datos") {
                    TextField("Nombre", text: $nombre)
                    TextField("Categoría", text: $categoria)
                }
                Section {
                    LabeledContent("Stock (u.)") {
                        TextField("0", text: $stockTexto)
                            .keyboardType(.numberPad)
                            .multilineTextAlignment(.trailing)
                            .disabled(tieneCompras)
                    }
                    LabeledContent("Costo promedio (S/)") {
                        TextField("0.00", text: $costoTexto)
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.trailing)
                            .disabled(tieneCompras)
                    }
                    Stepper("Stock mínimo: \(stockMinimo)", value: $stockMinimo, in: 0...1000)
                } header: {
                    Text("Inventario")
                } footer: {
                    if tieneCompras {
                        Text("Tiene compras: el stock y el costo promedio solo cambian al aprobar compras.")
                    }
                }
            }
            .navigationTitle(producto == nil ? "Nuevo producto" : "Editar producto")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancelar") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Guardar", action: guardar).disabled(!valido)
                }
            }
            .onAppear(perform: cargar)
        }
    }

    private func cargar() {
        guard let producto else { return }
        nombre = producto.nombre
        categoria = producto.categoria
        stockTexto = String(producto.stock)
        costoTexto = String(format: "%.2f", producto.costoPromedio)
        stockMinimo = producto.stockMinimo
    }

    private func guardar() {
        guard let stock, let costo else { return }
        let nombreLimpio = nombre.trimmingCharacters(in: .whitespaces)
        let categoriaLimpia = categoria.trimmingCharacters(in: .whitespaces)

        if let producto {
            producto.nombre = nombreLimpio
            producto.categoria = categoriaLimpia
            producto.stockMinimo = stockMinimo
            if !tieneCompras {
                producto.stock = stock
                producto.costoPromedio = costo
            }
        } else {
            contexto.insert(Producto(nombre: nombreLimpio, categoria: categoriaLimpia,
                                     stock: stock, costoPromedio: costo,
                                     stockMinimo: stockMinimo))
        }
        try? contexto.save()
        dismiss()
    }
}
