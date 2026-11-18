//
//  LoginView.swift
//  Compras
//
//  Created by Tecsup on 9/11/26.
//

import SwiftUI
import SwiftData

struct LoginView: View {
    @Environment(\.modelContext) private var contexto
    @Environment(SesionManager.self) private var sesion

    @State private var usuario = ""
    @State private var clave = ""
    @State private var mostrarError = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    // ① Logo y nombre
                    Image(systemName: "shippingbox.fill")
                        .font(.system(size: 44))
                        .foregroundStyle(.white)
                        .frame(width: 88, height: 88)
                        .background(LinearGradient(colors: [.tema, .teal],
                                                   startPoint: .topLeading,
                                                   endPoint: .bottomTrailing),
                                    in: RoundedRectangle(cornerRadius: 22))
                        .padding(.top, 40)

                    Text("Compras Tecsup").font(.title.bold())
                    Text("Inicia sesión para continuar").foregroundStyle(.secondary)

                    // ② Usuario
                    CampoTarjeta(titulo: "Usuario") {
                        TextField("usuario", text: $usuario)
                            .textInputAutocapitalization(.never)
                            .autocorrectionDisabled()
                    }
                    // ③ Clave oculta
                    CampoTarjeta(titulo: "Clave") {
                        SecureField("••••••", text: $clave)
                    }

                    // ④ Mensaje genérico: no dice si falló el usuario o la clave
                    if mostrarError {
                        Label("Usuario o clave incorrectos", systemImage: "exclamationmark.triangle.fill")
                            .font(.footnote)
                            .foregroundStyle(.red)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }

                    // ⑤ Ingresar
                    Button("Ingresar", action: ingresar)
                        .buttonStyle(BotonPrincipal())
                        .disabled(usuario.isEmpty || clave.isEmpty)

                    // Ⓐ Ir a Crear cuenta
                    HStack(spacing: 4) {
                        Text("¿Primera vez?").foregroundStyle(.secondary)
                        NavigationLink("Crear cuenta") { RegistroView() }
                            .fontWeight(.semibold)
                            .foregroundStyle(Color.tema)
                    }
                    .font(.footnote)
                }
                .padding()
            }
            .background(Color(.systemGroupedBackground))
        }
    }

    private func ingresar() {
        let entro = sesion.iniciarSesion(usuario: usuario, clave: clave, contexto: contexto)
        mostrarError = !entro
        if !entro { clave = "" }
    }
}
