//
//  ProductosView.swift
//  Compras
//
//  Created by Tecsup on 9/11/26.
//

import SwiftUI
import SwiftData

struct ProductosView: View {
    @Environment(\.modelContext) private var contexto
    @Environment(SesionManager.self) private var sesion
    @Query(sort: \Producto.nombre) private var productos: [Producto]

    @State private var busqueda = ""
    @State private var mostrarNuevo = false
    @State private var productoAEditar: Producto?
    @State private var mensajeBorrado: String?

    private var esSupervisor: Bool { sesion.usuarioActual?.esSupervisor ?? false }

    // ② Búsqueda por nombre o categoría
    private var filtrados: [Producto] {
        guard !busqueda.isEmpty else { return productos }
        return productos.filter {
            $0.nombre.localizedCaseInsensitiveContains(busqueda)
            || $0.categoria.localizedCaseInsensitiveContains(busqueda)
        }
    }

    // ④ Valor del inventario = suma de (stock × costo promedio)
    private var valorInventario: Double {
        productos.reduce(0) { $0 + $1.valorInventario }
    }

    var body: some View {
        NavigationStack {
            List {
                Section {
                    ForEach(filtrados) { producto in
                        FilaProducto(producto: producto)
                            .contextMenu {           // mantener presionado = editar (solo supervisor)
                                if esSupervisor {
                                    Button("Editar", systemImage: "pencil") {
                                        productoAEditar = producto
                                    }
                                }
                            }
                    }
                    // ⑤ Deslizar para borrar: solo el supervisor (nil = no se puede deslizar)
                    .onDelete(perform: esSupervisor ? borrar : nil)
                }

                Section {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Valor del inventario (stock × costo promedio)")
                            .font(.caption).foregroundStyle(.secondary)
                        Text(soles(valorInventario))
                            .font(.title2.bold())
                    }
                } footer: {
                    if esSupervisor {
                        Text("Desliza para borrar (bloqueado si tiene compras). Mantén presionado para editar.")
                    }
                }
            }
            .navigationTitle("Productos")
            .searchable(text: $busqueda, prompt: "Buscar")
            .toolbar {
                if esSupervisor {          // ① Botón + solo para el supervisor
                    ToolbarItem(placement: .topBarTrailing) {
                        Button { mostrarNuevo = true } label: { Image(systemName: "plus") }
                    }
                }
                ToolbarItem(placement: .topBarTrailing) { AvatarMenu() }
            }
            .overlay {
                if productos.isEmpty {
                    ContentUnavailableView("Sin productos", systemImage: "shippingbox",
                        description: Text(esSupervisor ? "Toca + para agregar el primero."
                                                       : "El supervisor aún no registró productos."))
                }
            }
            .sheet(isPresented: $mostrarNuevo) { ProductoFormView(producto: nil) }
            .sheet(item: $productoAEditar) { ProductoFormView(producto: $0) }
            .alert("No se puede borrar",
                   isPresented: Binding(get: { mensajeBorrado != nil },
                                        set: { if !$0 { mensajeBorrado = nil } })) {
                Button("Entendido", role: .cancel) {}
            } message: {
                Text(mensajeBorrado ?? "")
            }
        }
    }

    // Regla .deny: si tiene compras no se borra y se avisa
    private func borrar(_ indices: IndexSet) {
        for indice in indices {
            let producto = filtrados[indice]
            if producto.compras.isEmpty {
                contexto.delete(producto)
            } else {
                mensajeBorrado = "\(producto.nombre) tiene \(producto.compras.count) compra(s) registrada(s)."
            }
        }
        try? contexto.save()
    }
}

// ③ Fila con costo promedio y stock en color (regla R8)
struct FilaProducto: View {
    let producto: Producto

    private var colorStock: Color {
        producto.stockBajo ? .red : (producto.stockMedio ? .orange : .green)
    }

    var body: some View {
        HStack(spacing: 12) {
            IconoIniciales(nombre: producto.nombre)
            VStack(alignment: .leading, spacing: 2) {
                Text(producto.nombre).font(.headline).lineLimit(1)
                Text(producto.categoria).font(.caption).foregroundStyle(.secondary)
            }
            Spacer()
            VStack(alignment: .trailing, spacing: 2) {
                Text(soles(producto.costoPromedio)).font(.subheadline.bold())
                Text("costo prom.").font(.caption2).foregroundStyle(.secondary)
            }
            Insignia(texto: "\(producto.stock) u.", color: colorStock)
        }
    }
}s
