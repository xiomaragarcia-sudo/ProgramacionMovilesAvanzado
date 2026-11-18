//
//  ComprasApp.swift
//  Compras
//
//  Created by Tecsup on 9/11/26.
//

import SwiftUI
import SwiftData

@main
struct ComprasApp: App {
    @State private var sesion = SesionManager()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(sesion)
        }
        .modelContainer(for: [Usuario.self, Proveedor.self, Producto.self, Compra.self])
    }
}
