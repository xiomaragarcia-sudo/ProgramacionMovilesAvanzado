//
//  ContentView.swift
//  Compras
//
//  Created by Tecsup on 9/11/26.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(SesionManager.self) private var sesion

    var body: some View {
        if let usuario = sesion.usuarioActual {
            PrincipalView(usuario: usuario)
        } else {
            LoginView()
        }
    }
}

#Preview {
    ContentView()
        .environment(SesionManager())
        .modelContainer(for: [Usuario.self, Proveedor.self, Producto.self, Compra.self],
                        inMemory: true)
}
