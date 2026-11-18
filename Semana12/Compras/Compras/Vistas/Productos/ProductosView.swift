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
        return productos.filter { (p: Producto) -> Bool in
            p.nombre.localizedCaseInsensitiveContains(busqueda)
            || p.categoria.localizedCaseInsensitiveContains(busqueda)
        }
    }

    // ④ Valor del inventario = suma de (stock × costo promedio)
    private var valorInventario: Double {
        productos.reduce(0) { (suma: Double, p: Producto) -> Double in
            suma + p.valorInventario
        }
    }

    private var textoPie: String {
        esSupervisor
            ? "Toca un producto para ver su Kardex. Desliza para borrar (bloqueado si tiene compras). Mantén presionado para editar."
            : "Toca un producto para ver su Kardex."
    }

    // ① Barra superior: botón + (solo supervisor) y avatar
    @ToolbarContentBuilder
    private var barraSuperior: some ToolbarContent {
        ToolbarItemGroup(placement: .topBarTrailing) {
            if esSupervisor {
                Button { mostrarNuevo = true } label: { Image(systemName: "plus") }
            }
            AvatarMenu()
        }
    }

    var body: some View {
        NavigationStack {
            lista
                .navigationTitle("Productos")
                .searchable(text: $busqueda, prompt: "Buscar")
                .toolbar { barraSuperior }
                .overlay {
                    if productos.isEmpty {
                        ContentUnavailableView("Sin productos", systemImage: "shippingbox",
                            description: Text(esSupervisor ? "Toca + para agregar el primero."
                                                           : "El supervisor aún no registró productos."))
                    }
                }
                .sheet(isPresented: $mostrarNuevo) {
                    ProductoFormView(producto: nil)
                }
                .sheet(item: $productoAEditar) { (producto: Producto) in
                    ProductoFormView(producto: producto)
                }
                .alert("No se puede borrar",
                       isPresented: Binding(get: { mensajeBorrado != nil },
                                            set: { if !$0 { mensajeBorrado = nil } })) {
                    Button("Entendido", role: .cancel) {}
                } message: {
                    Text(mensajeBorrado ?? "")
                }
        }
    }

    // Lista de productos + valor del inventario
    private var lista: some View {
        List {
            Section {
                ForEach(filtrados) { (producto: Producto) in
                    fila(producto)
                }
                .onDelete(perform: borrar)
            }

            Section {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Valor del inventario (stock × costo promedio)")
                        .font(.caption).foregroundStyle(.secondary)
                    Text(soles(valorInventario))
                        .font(.title2.bold())
                }
            } footer: {
                Text(textoPie)
            }
        }
    }

    // Una fila: abre el Kardex; Editar y borrar solo para el supervisor
    private func fila(_ producto: Producto) -> some View {
        NavigationLink {
            KardexView(producto: producto)        // ★ B10
        } label: {
            FilaProducto(producto: producto)
        }
        .contextMenu {
            if esSupervisor {
                Button("Editar", systemImage: "pencil") {
                    productoAEditar = producto
                }
            }
        }
        .deleteDisabled(!esSupervisor)   // el comprador no puede deslizar para borrar
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
                if producto.stockBajo {
                    Text("Stock bajo").font(.caption2.bold()).foregroundStyle(.red)
                }
            }
            Spacer()
            VStack(alignment: .trailing, spacing: 2) {
                Text(soles(producto.costoPromedio)).font(.subheadline.bold())
                Text("costo prom.").font(.caption2).foregroundStyle(.secondary)
            }
            Insignia(texto: "\(producto.stock) u.", color: colorStock)
        }
    }
}
