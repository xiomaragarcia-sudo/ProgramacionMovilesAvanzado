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
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [Usuario.self, Proveedor.self, Producto.self, Compra.self])
    }
}
