//
//  MisComprasView.swift
//  Compras
//
//  Created by Tecsup on 9/11/26.
//
import SwiftUI
import SwiftData

// B6 · Mis compras (solo Comprador): ve únicamente las compras que él registró
struct MisComprasView: View {
    @Environment(SesionManager.self) private var sesion

    enum Filtro: String, CaseIterable {
        case todas = "Todas"
        case pendientes = "Pendientes"
        case rechazadas = "Rechazadas"
    }

    @State private var filtro: Filtro = .todas

    // ④ Solo las suyas: se usan las compras de la relación usuario → compras
    private var misCompras: [Compra] {
        (sesion.usuarioActual?.compras ?? []).sorted { $0.fecha > $1.fecha }
    }

    // ① Filtro del segmented
    private var filtradas: [Compra] {
        switch filtro {
        case .todas:      return misCompras
        case .pendientes: return misCompras.filter { $0.estado == "Pendiente" }
        case .rechazadas: return misCompras.filter { $0.estado == "Rechazada" }
        }
    }

    var body: some View {
        NavigationStack {
            List {
                Section {
                    Picker("Filtro", selection: $filtro) {
                        ForEach(Filtro.allCases, id: \.self) { opcion in
                            Text(opcion.rawValue).tag(opcion)
                        }
                    }
                    .pickerStyle(.segmented)
                    .listRowBackground(Color.clear)
                    .listRowInsets(EdgeInsets())
                }

                Section {
                    ForEach(filtradas) { compra in
                        FilaMiCompra(compra: compra)
                    }
                } footer: {
                    Text("Solo ves tus compras; no puedes pagar ni aprobar.")
                }
            }
            .navigationTitle("Mis compras")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) { AvatarMenu() }
            }
            .overlay {
                if filtradas.isEmpty {
                    ContentUnavailableView("Sin compras", systemImage: "cart",
                        description: Text(filtro == .todas ? "Registra una compra en la pestaña Compra."
                                                           : "No tienes compras \(filtro.rawValue.lowercased())."))
                }
            }
        }
    }
}

// ② ③ Fila con estado; si fue rechazada, muestra el motivo
struct FilaMiCompra: View {
    let compra: Compra

    private var colorEstado: Color {
        switch compra.estado {
        case "Aprobada":  return .green
        case "Rechazada": return .red
        default:          return .orange
        }
    }

    private var iconoEstado: String {
        switch compra.estado {
        case "Aprobada":  return "checkmark"
        case "Rechazada": return "xmark"
        default:          return "hourglass"
        }
    }

    // "03/11"
    private var fechaCorta: String {
        let formato = DateFormatter()
        formato.dateFormat = "dd/MM"
        return formato.string(from: compra.fecha)
    }

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: iconoEstado)
                .font(.headline)
                .foregroundStyle(.white)
                .frame(width: 40, height: 40)
                .background(colorEstado, in: RoundedRectangle(cornerRadius: 10))

            VStack(alignment: .leading, spacing: 2) {
                Text(compra.proveedor?.nombre ?? "Sin proveedor")
                    .font(.headline).lineLimit(1)
                Text("\(compra.producto?.nombre ?? "Producto") × \(compra.cantidad) · \(fechaCorta)")
                    .font(.caption).foregroundStyle(.secondary).lineLimit(1)
                if compra.estado == "Rechazada", let motivo = compra.motivoRechazo {
                    Text("Motivo: \(motivo)")
                        .font(.caption.bold())
                        .foregroundStyle(.red)
                        .lineLimit(2)
                }
            }

            Spacer()

            VStack(alignment: .trailing, spacing: 4) {
                Text(soles(compra.total)).font(.subheadline.bold())
                Insignia(texto: compra.estado, color: colorEstado)
            }
        }
    }
}
