//
//  RegistroView.swift
//  Compras
//
//  Created by Tecsup on 9/11/26.
//

import SwiftUI
import SwiftData

struct RegistroView: View {
    @Environment(\.modelContext) private var contexto
    @Environment(SesionManager.self) private var sesion

    @State private var nombre = ""
    @State private var usuario = ""
    @State private var clave = ""
    @State private var confirmacion = ""
    @State private var rol = "Comprador"
    @State private var mensajeError: String?

    private var usuarioLimpio: String {
        usuario.trimmingCharacters(in: .whitespaces).lowercased()
    }
    private var usuarioExiste: Bool {
        !usuarioLimpio.isEmpty && sesion.existeUsuario(usuarioLimpio, contexto: contexto)
    }
    private var formularioValido: Bool {
        !nombre.trimmingCharacters(in: .whitespaces).isEmpty
        && !usuarioLimpio.isEmpty && !usuarioExiste
        && clave.count >= 6 && clave == confirmacion
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 14) {
                // ② Nombre completo
                CampoTarjeta(titulo: "Nombre completo") {
                    TextField("Lucía Paredes", text: $nombre)
                }

                // ③ Usuario único, con aviso
                CampoTarjeta(titulo: "Usuario") {
                    HStack {
                        TextField("lparedes", text: $usuario)
                            .textInputAutocapitalization(.never)
                            .autocorrectionDisabled()
                        if !usuarioLimpio.isEmpty {
                            if usuarioExiste {
                                Label("Ya existe", systemImage: "xmark.circle.fill")
                                    .font(.caption).foregroundStyle(.red)
                            } else {
                                Label("Disponible", systemImage: "checkmark")
                                    .font(.caption).foregroundStyle(.green)
                            }
                        }
                    }
                }

                // ④ Clave y confirmación
                CampoTarjeta(titulo: "Clave (mínimo 6 caracteres)") {
                    SecureField("••••••", text: $clave)
                }
                CampoTarjeta(titulo: "Confirmar clave") {
                    SecureField("••••••", text: $confirmacion)
                }
                if !clave.isEmpty && clave.count < 6 {
                    aviso("La clave debe tener mínimo 6 caracteres")
                }
                if !confirmacion.isEmpty && confirmacion != clave {
                    aviso("Las claves no coinciden")
                }

                // ⑤ Rol
                VStack(alignment: .leading, spacing: 6) {
                    Text("TU ROL")
                        .font(.caption2.weight(.semibold))
                        .foregroundStyle(.secondary)
                    Picker("Rol", selection: $rol) {
                        Text("Comprador").tag("Comprador")
                        Text("Supervisor").tag("Supervisor")
                    }
                    .pickerStyle(.segmented)
                }

                if let mensajeError { aviso(mensajeError) }

                // Ⓐ Registrarme: entra directo a la app
                Button("Registrarme", action: registrar)
                    .buttonStyle(BotonPrincipal())
                    .disabled(!formularioValido)

                Text("Al registrarte entrarás directamente a la app con las pestañas de tu rol.")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
            }
            .padding()
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle("Crear cuenta")          // ① Título (el botón volver lo pone Xcode)
        .navigationBarTitleDisplayMode(.inline)
    }

    private func aviso(_ texto: String) -> some View {
        Label(texto, systemImage: "exclamationmark.triangle.fill")
            .font(.footnote)
            .foregroundStyle(.red)
            .frame(maxWidth: .infinity, alignment: .leading)
    }

    private func registrar() {
        mensajeError = sesion.registrar(nombre: nombre, usuario: usuario, clave: clave,
                                        confirmacion: confirmacion, rol: rol,
                                        contexto: contexto)
    }
}
