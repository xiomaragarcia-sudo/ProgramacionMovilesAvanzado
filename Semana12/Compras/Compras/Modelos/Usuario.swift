//
//  Usuario.swift
//  Compras
//
//  Created by Tecsup on 9/11/26.
//

import Foundation
import SwiftData

@Model
final class Usuario {
    var nombre: String
    var usuario: String      // se guarda en minúsculas: "MTorres" == "mtorres"
    var clave: String
    var rol: String          // "Comprador" o "Supervisor"

    // Un usuario registra muchas compras.
    // .deny: no se puede borrar si tiene compras.
    @Relationship(deleteRule: .deny, inverse: \Compra.comprador)
    var compras: [Compra] = []

    init(nombre: String, usuario: String, clave: String, rol: String) {
        self.nombre = nombre
        self.usuario = usuario.lowercased()
        self.clave = clave
        self.rol = rol
    }

    var esSupervisor: Bool { rol == "Supervisor" }

    // "Marco Torres" -> "MT" (para el avatar)
    var iniciales: String {
        nombre.split(separator: " ").prefix(2)
            .compactMap { $0.first }.map(String.init).joined().uppercased()
    }
}
