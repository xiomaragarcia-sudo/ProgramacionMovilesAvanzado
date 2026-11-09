//
//  Tema.swift
//  Compras
//
//  Created by Tecsup on 9/11/26.
//

import SwiftUI

// Verde de la maqueta
extension Color {
    static let tema = Color(red: 0.11, green: 0.53, blue: 0.45)
}

// Tarjeta blanca con título pequeño en mayúsculas (como en la maqueta)
struct CampoTarjeta<Contenido: View>: View {
    let titulo: String
    @ViewBuilder let contenido: () -> Contenido

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(titulo.uppercased())
                .font(.caption2.weight(.semibold))
                .foregroundStyle(.secondary)
            contenido()
        }
        .padding(12)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(.secondarySystemGroupedBackground),
                    in: RoundedRectangle(cornerRadius: 14))
    }
}

// Botón verde grande; se ve apagado si está deshabilitado
struct BotonPrincipal: ButtonStyle {
    @Environment(\.isEnabled) private var habilitado

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline)
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.tema.opacity(habilitado ? (configuration.isPressed ? 0.8 : 1) : 0.4),
                        in: RoundedRectangle(cornerRadius: 14))
    }
}
