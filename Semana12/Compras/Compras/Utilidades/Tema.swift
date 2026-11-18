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

// MARK: - Ayudas de formato

// 13120 -> "S/ 13,120.00"
func soles(_ valor: Double) -> String {
    "S/ " + valor.formatted(.number.precision(.fractionLength(2))
                                .locale(Locale(identifier: "en_US")))
}

// "Laptop Pro 14" -> "LP"
func iniciales(de texto: String) -> String {
    texto.split(separator: " ").prefix(2)
        .compactMap { $0.first }.map(String.init).joined().uppercased()
}

// Siempre el mismo color para el mismo nombre
func colorPara(_ texto: String) -> Color {
    let paleta: [Color] = [.tema, .blue, .purple, .teal, .red, .orange, .indigo]
    let suma = texto.unicodeScalars.reduce(0) { $0 + Int($1.value) }
    return paleta[suma % paleta.count]
}

// Cuadrito de color con iniciales (filas de productos y proveedores)
struct IconoIniciales: View {
    let nombre: String
    var body: some View {
        Text(iniciales(de: nombre))
            .font(.subheadline.bold())
            .foregroundStyle(.white)
            .frame(width: 40, height: 40)
            .background(colorPara(nombre), in: RoundedRectangle(cornerRadius: 10))
    }
}

// Pastilla de color: "40 u.", "Al día", "2 por pagar", "VENCIDA"...
struct Insignia: View {
    let texto: String
    let color: Color
    var body: some View {
        Text(texto)
            .font(.caption2.bold())
            .foregroundStyle(.white)
            .padding(.horizontal, 8)
            .padding(.vertical, 3)
            .background(color, in: Capsule())
    }
}
