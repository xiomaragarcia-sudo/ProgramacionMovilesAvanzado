//
//  User.swift
//  Semana13_MetodosAPI
//
//  Created by Juan Leon - Jaime Gómez
//  Utilizando los métodos POST - PUT - DELETE
//

import Foundation

struct User: Codable, Identifiable {
    let id: Int
    let name: String
    let email: String
}
