//
//  PorPagarView.swift
//  Compras
//
//  Created by Tecsup on 9/11/26.
//

import SwiftUI
import SwiftData

// B8 · Por pagar (solo Supervisor)
enum FiltroPago: String, CaseIterable {
    case pendientes = "Pendientes"
    case vencidas = "Vencidas"
    case pagadas = "Pagadas"
}

struct PorPagarView: View {
    @State private var filtro: FiltroPago = .pendientes
    @State private var busqueda = ""

    // ⑤ Total por pagar: aprobadas, a crédito y sin pagar (#Predicate)
    @Query(filter: #Predicate<Compra> { $0.alCredito && $0.estado == "Aprobada" && !$0.pagada })
    private var sinPagar: [Compra]

    private var totalPorPagar: Double {
        sinPagar.reduce(0) { $0 + $1.total }
    }

    var body: some View {
        NavigationStack {
            List {
                // ① Segmented Pendientes / Vencidas / Pagadas
                Section {
                    Picker("Filtro", selection: $filtro) {
                        ForEach(FiltroPago.allCases, id: \.self) { opcion in
                            Text(opcion.rawValue).tag(opcion)
                        }
                    }
                    .pickerStyle(.segmented)
                    .listRowBackground(Color.clear)
                    .listRowInsets(EdgeInsets())
                }

                // La lista cambia su #Predicate según el filtro
                ListaPorPagar(filtro: filtro, busqueda: busqueda)

                Section {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Total por pagar").font(.caption).foregroundStyle(.secondary)
                        Text(soles(totalPorPagar)).font(.title.bold())
                    }
                } footer: {
                    Text("Solo cuentan compras aprobadas a crédito y no pagadas.")
                }
            }
            .navigationTitle("Por pagar")
            .searchable(text: $busqueda, prompt: "Buscar por proveedor")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) { AvatarMenu() }
            }
        }
    }
}

// Lista filtrada con #Predicate (Nivel +)
struct ListaPorPagar: View {
    @Environment(\.modelContext) private var contexto
    @Environment(SesionManager.self) private var sesion
    @Query private var compras: [Compra]

    let filtro: FiltroPago
    let busqueda: String

    init(filtro: FiltroPago, busqueda: String) {
        self.filtro = filtro
        self.busqueda = busqueda

        let ahora = Date.now
        let predicado: Predicate<Compra>
        switch filtro {
        case .pendientes:   // todas las que faltan pagar (incluye vencidas)
            predicado = #Predicate<Compra> {
                $0.alCredito && $0.estado == "Aprobada" && !$0.pagada
            }
        case .vencidas:     // faltan pagar y la fecha ya pasó
            predicado = #Predicate<Compra> {
                $0.alCredito && $0.estado == "Aprobada" && !$0.pagada && $0.vence < ahora
            }
        case .pagadas:
            predicado = #Predicate<Compra> {
                $0.alCredito && $0.estado == "Aprobada" && $0.pagada
            }
        }
        _compras = Query(filter: predicado, sort: \Compra.vence)
    }

    private var esSupervisor: Bool { sesion.usuarioActual?.esSupervisor ?? false }

    // Búsqueda por proveedor
    private var filtradas: [Compra] {
        guard !busqueda.isEmpty else { return compras }
        return compras.filter {
            ($0.proveedor?.nombre ?? "").localizedCaseInsensitiveContains(busqueda)
        }
    }

    var body: some View {
        Section {
            if filtradas.isEmpty {
                Text("No hay compras \(filtro.rawValue.lowercased()).")
                    .foregroundStyle(.secondary)
            }
            ForEach(filtradas) { compra in
                FilaPorPagar(compra: compra)
                    // ④ Deslizar Pagar (solo supervisor y solo si falta pagar)
                    .swipeActions(edge: .trailing) {
                        if esSupervisor && !compra.pagada {
                            Button("Pagar") {
                                compra.pagar()
                                try? contexto.save()
                            }
                            .tint(.tema)
                        }
                    }
                    #if DEBUG
                    // Solo para probar el caso 8 (no aparece en la app final)
                    .contextMenu {
                        if !compra.pagada {
                            Button("Simular vencimiento (prueba)", systemImage: "calendar.badge.exclamationmark") {
                                compra.vence = Calendar.current.date(byAdding: .day, value: -1, to: .now) ?? .now
                                try? contexto.save()
                            }
                        }
                    }
                    #endif
            }
        }
    }
}

// ② Fila de compra a crédito · ③ etiqueta VENCIDA
struct FilaPorPagar: View {
    let compra: Compra

    private var venceCorto: String {
        let formato = DateFormatter()
        formato.dateFormat = "dd/MM"
        return formato.string(from: compra.vence)
    }

    var body: some View {
        HStack(spacing: 12) {
            IconoIniciales(nombre: compra.proveedor?.nombre ?? "?")
            VStack(alignment: .leading, spacing: 2) {
                Text(compra.proveedor?.nombre ?? "Proveedor").font(.headline).lineLimit(1)
                Text("\(compra.producto?.nombre ?? "Producto") × \(compra.cantidad) · vence \(venceCorto)")
                    .font(.caption).foregroundStyle(.secondary).lineLimit(1)
            }
            Spacer()
            VStack(alignment: .trailing, spacing: 4) {
                Text(soles(compra.total)).font(.subheadline.bold())
                if compra.pagada {
                    Insignia(texto: "Pagada", color: .green)
                } else if compra.estaVencida {
                    Insignia(texto: "VENCIDA", color: .red)
                }
            }
        }
    }
}
