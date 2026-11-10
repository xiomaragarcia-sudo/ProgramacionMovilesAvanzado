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
        return proveedores.filter { (p: Proveedor) -> Bool in
            p.nombre.localizedCaseInsensitiveContains(busqueda) || p.ruc.contains(busqueda)
        }
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
                .navigationTitle("Proveedores")
                .searchable(text: $busqueda, prompt: "Buscar por nombre o RUC")
                .toolbar { barraSuperior }
                .overlay {
                    if proveedores.isEmpty {
                        ContentUnavailableView("Sin proveedores", systemImage: "building.2",
                            description: Text(esSupervisor ? "Toca + para agregar el primero."
                                                           : "El supervisor aún no registró proveedores."))
                    }
                }
                .sheet(isPresented: $mostrarNuevo) {
                    ProveedorFormView(proveedor: nil)
                }
                .sheet(item: $proveedorAEditar) { (proveedor: Proveedor) in
                    ProveedorFormView(proveedor: proveedor)
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

    // ② Lista de proveedores
    private var lista: some View {
        List {
            Section {
                ForEach(filtrados) { (proveedor: Proveedor) in
                    fila(proveedor)
                }
                .onDelete(perform: borrar)
            } footer: {
                Text("\"Por pagar\" y \"comprado\" se calculan de las compras del proveedor (relación proveedor → compras).")
            }
        }
    }

    // Una fila: menú Editar y borrado solo para el supervisor
    private func fila(_ proveedor: Proveedor) -> some View {
        FilaProveedor(proveedor: proveedor)
            .contextMenu {
                if esSupervisor {
                    Button("Editar", systemImage: "pencil") {
                        proveedorAEditar = proveedor
                    }
                }
            }
            .deleteDisabled(!esSupervisor)   // el comprador no puede deslizar para borrar
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

// Fila con total comprado e insignia "por pagar" o "Al día"
struct FilaProveedor: View {
    let proveedor: Proveedor

    var body: some View {
        HStack(spacing: 12) {
            IconoIniciales(nombre: proveedor.nombre)
            VStack(alignment: .leading, spacing: 2) {
                Text(proveedor.nombre).font(.headline).lineLimit(1)
                Text("RUC …" + String(proveedor.ruc.suffix(4)))
                    .font(.caption).foregroundStyle(.secondary)
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
