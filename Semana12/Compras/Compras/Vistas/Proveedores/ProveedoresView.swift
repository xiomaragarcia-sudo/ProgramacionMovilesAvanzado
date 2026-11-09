//
//  ProveedoresView.swift
//  Compras
//
//  Created by Tecsup on 9/11/26.
//

import SwiftUI
import SwiftData

struct ProveedoresView: View {
    @Environment(\.modelContext) private var contexto
    @Environment(SesionManager.self) private var sesion
    @Query(sort: \Proveedor.nombre) private var proveedores: [Proveedor]

    @State private var busqueda = ""
    @State private var mostrarNuevo = false
    @State private var proveedorAEditar: Proveedor?
    @State private var mensajeBorrado: String?

    private var esSupervisor: Bool { sesion.usuarioActual?.esSupervisor ?? false }

    // Búsqueda por nombre o RUC
    private var filtrados: [Proveedor] {
        guard !busqueda.isEmpty else { return proveedores }
        return proveedores.filter {
            $0.nombre.localizedCaseInsensitiveContains(busqueda) || $0.ruc.contains(busqueda)
        }
    }

    var body: some View {
        NavigationStack {
            List {
                Section {
                    ForEach(filtrados) { proveedor in
                        FilaProveedor(proveedor: proveedor)
                            .contextMenu {           // mantener presionado = editar (solo supervisor)
                                if esSupervisor {
                                    Button("Editar", systemImage: "pencil") {
                                        proveedorAEditar = proveedor
                                    }
                                }
                            }
                    }
                    .onDelete(perform: esSupervisor ? borrar : nil)
                } footer: {
                    // ③ Valores calculados desde las compras del proveedor
                    Text("\"Por pagar\" y \"comprado\" se calculan de las compras del proveedor (relación proveedor → compras).")
                }
            }
            .navigationTitle("Proveedores")
            .searchable(text: $busqueda, prompt: "Buscar por nombre o RUC")
            .toolbar {
                if esSupervisor {          // ① Botón + solo para el supervisor
                    ToolbarItem(placement: .topBarTrailing) {
                        Button { mostrarNuevo = true } label: { Image(systemName: "plus") }
                    }
                }
                ToolbarItem(placement: .topBarTrailing) { AvatarMenu() }
            }
            .overlay {
                if proveedores.isEmpty {
                    ContentUnavailableView("Sin proveedores", systemImage: "building.2",
                        description: Text(esSupervisor ? "Toca + para agregar el primero."
                                                       : "El supervisor aún no registró proveedores."))
                }
            }
            .sheet(isPresented: $mostrarNuevo) { ProveedorFormView(proveedor: nil) }
            .sheet(item: $proveedorAEditar) { ProveedorFormView(proveedor: $0) }
            .alert("No se puede borrar",
                   isPresented: Binding(get: { mensajeBorrado != nil },
                                        set: { if !$0 { mensajeBorrado = nil } })) {
                Button("Entendido", role: .cancel) {}
            } message: {
                Text(mensajeBorrado ?? "")
            }
        }
    }

    // Regla .deny: si tiene compras no se borra
    private func borrar(_ indices: IndexSet) {
        for indice in indices {
            let proveedor = filtrados[indice]
            if proveedor.compras.isEmpty {
                contexto.delete(proveedor)
            } else {
                mensajeBorrado = "\(proveedor.nombre) tiene \(proveedor.compras.count) compra(s) registrada(s)."
            }
        }
        try? contexto.save()
    }
}

// ② Fila con total comprado e insignia "por pagar" o "Al día"
struct FilaProveedor: View {
    let proveedor: Proveedor

    var body: some View {
        HStack(spacing: 12) {
            IconoIniciales(nombre: proveedor.nombre)
            VStack(alignment: .leading, spacing: 2) {
                Text(proveedor.nombre).font(.headline).lineLimit(1)
                Text("RUC …\(proveedor.ruc.suffix(4))").font(.caption).foregroundStyle(.secondary)
            }
            Spacer()
            VStack(alignment: .trailing, spacing: 2) {
                Text(soles(proveedor.totalComprado)).font(.subheadline.bold())
                Text("comprado").font(.caption2).foregroundStyle(.secondary)
            }
            if proveedor.cantidadPorPagar > 0 {
                Insignia(texto: "\(proveedor.cantidadPorPagar) por pagar", color: .red)
            } else {
                Insignia(texto: "Al día", color: .green)
            }
        }
    }
}
