//
//  PrincipalView.swift
//  Compras
//
//  Created by Tecsup on 9/11/26.
//

import SwiftUI

struct PrincipalView: View {
    @Environment(SesionManager.self) private var sesion
    let usuario: Usuario

    var body: some View {
        VStack(spacing: 12) {
            Text("Hola, \(usuario.nombre)").font(.title2.bold())
            Text(usuario.rol).foregroundStyle(.secondary)
            Button("Cerrar sesión", role: .destructive) {
                sesion.cerrarSesion()
            }
        }
    }
}
