//
//  User.swift
//  Semana13_API
//
//  Created by Juan Leon - Jaime Gómez
//

import Foundation
//Codable: permite convertir entre esta estructura y datos JSON automáticamente.
//Identifiable: es un protocolo que permite que SwiftUI sepa cómo identificar cada elemento en una lista
struct User: Codable, Identifiable {
    let id: Int
    let name: String
}
