//
//  NuevaCompraView.swift
//  Compras
//
//  Created by Tecsup on 9/11/26.
//import SwiftUI

import SwiftUI
import SwiftData

// B5 · Nueva compra (solo Comprador)
struct NuevaCompraView: View {
    @Environment(\.modelContext) private var contexto
    @Environment(SesionManager.self) private var sesion
    @Query(sort: \Proveedor.nombre) private var proveedores: [Proveedor]
    @Query(sort: \Producto.nombre) private var productos: [Producto]

    @State private var proveedor: Proveedor?
    @State private var producto: Producto?
    @State private var cantidadTexto = ""
    @State private var costoTexto = ""
    @State private var alCredito = false
    @State private var mensaje: String?

    // Cálculos en vivo (R1)
    private var cantidad: Int { Int(cantidadTexto) ?? 0 }
    private var costoUnitario: Double {
        Double(costoTexto.replacingOccurrences(of: ",", with: ".")) ?? 0
    }
    private var subtotal: Double { Double(cantidad) * costoUnitario }
    private var igv: Double { Compra.redondear(subtotal * Compra.tasaIGV) }
    private var total: Double { Compra.redondear(subtotal + igv) }
    private var requiereAprobacion: Bool { total >= Compra.montoAprobacion }   // R2

    private var valido: Bool {
        proveedor != nil && producto != nil && cantidad > 0 && costoUnitario > 0
    }

    private var faltanDatos: Bool { proveedores.isEmpty || productos.isEmpty }

    var body: some View {
        NavigationStack {
            Group {
                if faltanDatos {
                    // Sin proveedores o productos no se puede comprar
                    ContentUnavailableView("Faltan datos", systemImage: "cart",
                        description: Text("El supervisor debe registrar al menos un proveedor y un producto."))
                } else {
                    formulario
                }
            }
            .navigationTitle("Nueva compra")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) { AvatarMenu() }   // ① Avatar
            }
            .alert("Compra registrada",
                   isPresented: Binding(get: { mensaje != nil },
                                        set: { if !$0 { mensaje = nil } })) {
                Button("OK", role: .cancel) {}
            } message: {
                Text(mensaje ?? "")
            }
        }
    }

    private var formulario: some View {
        Form {
            // ② Proveedor · ③ Producto
            Section {
                Picker("Proveedor", selection: $proveedor) {
                    Text("Selecciona").tag(Proveedor?.none)
                    ForEach(proveedores) { (p: Proveedor) in
                        Text(p.nombre).tag(Optional(p))
                    }
                }
                Picker("Producto", selection: $producto) {
                    Text("Selecciona").tag(Producto?.none)
                    ForEach(productos) { (p: Producto) in
                        Text(p.nombre).tag(Optional(p))
                    }
                }
            }
            .pickerStyle(.navigationLink)

            // ④ Cantidad y costo unitario
            Section {
                LabeledContent("Cantidad") {
                    TextField("0", text: $cantidadTexto)
                        .keyboardType(.numberPad)
                        .multilineTextAlignment(.trailing)
                }
                LabeledContent("Costo unitario") {
                    TextField("0.00", text: $costoTexto)
                        .keyboardType(.decimalPad)
                        .multilineTextAlignment(.trailing)
                }
            }

            // ⑤ Contado o Crédito 30 días
            Section {
                Picker("Forma de pago", selection: $alCredito) {
                    Text("Contado").tag(false)
                    Text("Crédito 30 días").tag(true)
                }
                .pickerStyle(.segmented)
            }

            // Subtotal, IGV y total
            Section {
                LabeledContent("Subtotal", value: soles(subtotal))
                LabeledContent("IGV 18%", value: soles(igv))
                LabeledContent {
                    Text(soles(total)).bold()
                } label: {
                    Text("Total").bold()
                }
            }

            // Ⓐ Aviso cuando el total llega a S/ 5,000
            if requiereAprobacion {
                Section {
                    Label {
                        Text("Supera S/ 5,000: quedará **pendiente de aprobación** del supervisor. No cambia stock ni costo promedio todavía.")
                    } icon: {
                        Image(systemName: "exclamationmark.triangle.fill")
                    }
                    .font(.footnote)
                    .foregroundStyle(.orange)
                }
                .listRowBackground(Color.yellow.opacity(0.15))
            }

            // ⑦ Botón con texto dinámico
            Section {
                Button(requiereAprobacion ? "Enviar a aprobación" : "Registrar compra",
                       action: registrar)
                    .buttonStyle(BotonPrincipal())
                    .disabled(!valido)
            }
            .listRowInsets(EdgeInsets())
            .listRowBackground(Color.clear)
        }
    }

    private func registrar() {
        guard let usuario = sesion.usuarioActual,
              let proveedorElegido = proveedor,
              let productoElegido = producto else { return }

        // Cada compra guarda quién la registró (comprador = usuario de la sesión)
        let compra = Compra(cantidad: cantidad, costoUnitario: costoUnitario,
                            alCredito: alCredito, comprador: usuario,
                            proveedor: proveedorElegido, producto: productoElegido)
        contexto.insert(compra)

        if compra.requiereAprobacion {
            // R2: ≥ S/ 5,000 queda Pendiente y no toca stock ni costo
            mensaje = "Total \(soles(compra.total)). Quedó pendiente de aprobación del supervisor."
        } else {
            // R2: < S/ 5,000 queda Aprobada al instante
            compra.aprobar()
            let pago = compra.alCredito
                ? "Vence el \(compra.vence.formatted(date: .numeric, time: .omitted))."
                : "Pagada al contado."
            mensaje = "Total \(soles(compra.total)). Aprobada: stock \(productoElegido.stock) u. · costo promedio \(soles(productoElegido.costoPromedio)). \(pago)"
        }
        try? contexto.save()

        // Limpia el formulario
        producto = nil
        cantidadTexto = ""
        costoTexto = ""
        alCredito = false
    }
}
