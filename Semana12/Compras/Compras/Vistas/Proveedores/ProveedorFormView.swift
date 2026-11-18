//
//  ProveedorFormView.swift
//  Compras
//
//  Created by Tecsup on 9/11/26.
//

import SwiftUI
import SwiftData

// Formulario para crear (proveedor == nil) o editar un proveedor. Solo lo abre el supervisor.
struct ProveedorFormView: View {
    @Environment(\.modelContext) private var contexto
    @Environment(\.dismiss) private var dismiss

    let proveedor: Proveedor?

    @State private var nombre = ""
    @State private var ruc = ""

    // RUC peruano: 11 dígitos
    private var rucValido: Bool { ruc.count == 11 && ruc.allSatisfy(\.isNumber) }
    private var valido: Bool {
        !nombre.trimmingCharacters(in: .whitespaces).isEmpty && rucValido
    }

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Razón social", text: $nombre)
                    TextField("RUC (11 dígitos)", text: $ruc)
                        .keyboardType(.numberPad)
                } footer: {
                    if !ruc.isEmpty && !rucValido {
                        Text("El RUC debe tener 11 dígitos.").foregroundStyle(.red)
                    }
                }
            }
            .navigationTitle(proveedor == nil ? "Nuevo proveedor" : "Editar proveedor")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancelar") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Guardar", action: guardar).disabled(!valido)
                }
            }
            .onAppear {
                if let proveedor {
                    nombre = proveedor.nombre
                    ruc = proveedor.ruc
                }
            }
        }
    }

    private func guardar() {
        let nombreLimpio = nombre.trimmingCharacters(in: .whitespaces)
        if let proveedor {
            proveedor.nombre = nombreLimpio
            proveedor.ruc = ruc
        } else {
            contexto.insert(Proveedor(nombre: nombreLimpio, ruc: ruc))
        }
        try? contexto.save()
        dismiss()
    }
}
