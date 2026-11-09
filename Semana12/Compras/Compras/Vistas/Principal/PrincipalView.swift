//
//  PrincipalView.swift
//  Compras
//
//  Created by Tecsup on 9/11/26.
//

import SwiftUI

// TabView cuyas pestañas dependen del rol (matriz de permisos del expediente)
struct PrincipalView: View {
    let usuario: Usuario

    var body: some View {
        TabView {
            if usuario.esSupervisor {
                PendienteView(titulo: "Resumen")
                    .tabItem { Label("Resumen", systemImage: "chart.bar.fill") }
                PendienteView(titulo: "Aprobar")
                    .tabItem { Label("Aprobar", systemImage: "checkmark.seal.fill") }
                PendienteView(titulo: "Por pagar")
                    .tabItem { Label("Por pagar", systemImage: "creditcard.fill") }
                ProductosView()
                    .tabItem { Label("Productos", systemImage: "shippingbox.fill") }
                ProveedoresView()
                    .tabItem { Label("Proveedores", systemImage: "building.2.fill") }
            } else {
                ProductosView()
                    .tabItem { Label("Productos", systemImage: "shippingbox.fill") }
                ProveedoresView()
                    .tabItem { Label("Proveedores", systemImage: "building.2.fill") }
                NuevaCompraView()
                    .tabItem { Label("Compra", systemImage: "cart.fill.badge.plus") }
                MisComprasView()
                    .tabItem { Label("Mis compras", systemImage: "list.bullet.rectangle.fill") }
            }
        }
        .tint(.tema)
    }
}
