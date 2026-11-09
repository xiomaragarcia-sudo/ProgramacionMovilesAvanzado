//
//  SesionManeger.swift
//  Compras
//
//  Created by Tecsup on 9/11/26.
//

import Foundation
import SwiftData
import CryptoKit
import Observation

// Recuerda al usuario conectado mientras la app está abierta.
@Observable
final class SesionManager {
    var usuarioActual: Usuario?

    // La clave no se guarda en texto plano, sino como hash SHA-256.
    static func hash(_ clave: String) -> String {
        SHA256.hash(data: Data(clave.utf8))
            .map { String(format: "%02x", $0) }
            .joined()
    }

    // R7: usuario único sin distinguir mayúsculas (se guarda en minúsculas)
    func existeUsuario(_ usuario: String, contexto: ModelContext) -> Bool {
        let buscado = usuario.trimmingCharacters(in: .whitespaces).lowercased()
        let descriptor = FetchDescriptor<Usuario>(
            predicate: #Predicate<Usuario> { $0.usuario == buscado })
        return ((try? contexto.fetchCount(descriptor)) ?? 0) > 0
    }

    // Devuelve true si entra. Si falla, la vista muestra un mensaje genérico.
    func iniciarSesion(usuario: String, clave: String, contexto: ModelContext) -> Bool {
        let buscado = usuario.trimmingCharacters(in: .whitespaces).lowercased()
        let claveHash = Self.hash(clave)
        let descriptor = FetchDescriptor<Usuario>(
            predicate: #Predicate<Usuario> { $0.usuario == buscado && $0.clave == claveHash })

        guard let encontrado = try? contexto.fetch(descriptor).first else { return false }
        usuarioActual = encontrado
        return true
    }

    // Devuelve nil si se registró bien, o el mensaje de error.
    func registrar(nombre: String, usuario: String, clave: String,
                   confirmacion: String, rol: String,
                   contexto: ModelContext) -> String? {
        let nombreLimpio = nombre.trimmingCharacters(in: .whitespaces)
        let usuarioLimpio = usuario.trimmingCharacters(in: .whitespaces).lowercased()

        if nombreLimpio.isEmpty || usuarioLimpio.isEmpty { return "Completa nombre y usuario" }
        if usuarioLimpio.contains(" ") { return "El usuario no puede tener espacios" }
        if existeUsuario(usuarioLimpio, contexto: contexto) { return "El usuario \"\(usuarioLimpio)\" ya existe" }
        if clave.count < 6 { return "La clave debe tener mínimo 6 caracteres" }
        if clave != confirmacion { return "Las claves no coinciden" }

        let nuevo = Usuario(nombre: nombreLimpio, usuario: usuarioLimpio,
                            clave: Self.hash(clave), rol: rol)
        contexto.insert(nuevo)
        try? contexto.save()
        usuarioActual = nuevo          // al registrarse entra directo a la app
        return nil
    }

    func cerrarSesion() {
        usuarioActual = nil            // vuelve al login
    }
}
