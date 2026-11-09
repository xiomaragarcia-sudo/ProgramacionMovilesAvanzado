//
//  AvatarMenu.swift
//  Compras
//
//  Created by Tecsup on 9/11/26.
//

import SwiftUI

// Círculo con las iniciales del usuario; al tocarlo muestra nombre, rol y Cerrar sesión.
struct AvatarMenu: View {
    @Environment(SesionManager.self) private var sesion

    var body: some View {
        if let usuario = sesion.usuarioActual {
            Menu {
                Section("\(usuario.nombre) · \(usuario.rol)") {
                    Button("Cerrar sesión",
                           systemImage: "rectangle.portrait.and.arrow.right",
                           role: .destructive) {
                        sesion.cerrarSesion()
                    }
                }
            } label: {
                Text(usuario.iniciales)
                    .font(.caption.bold())
                    .foregroundStyle(.white)
                    .frame(width: 34, height: 34)
                    .background(Color.tema, in: Circle())
            }
        }
    }
}
