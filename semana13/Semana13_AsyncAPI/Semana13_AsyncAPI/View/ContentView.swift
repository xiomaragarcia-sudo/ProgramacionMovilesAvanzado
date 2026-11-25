//
//  ContentView.swift
//  Semana13_AsyncAPI
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = UserViewModel()

    @State private var showingForm = false
    @State private var editingUser: User? = nil

    var body: some View {
        NavigationView {
            VStack {
                TextField("Buscar usuario por nombre", text: $viewModel.searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                List(viewModel.filteredUsers) { user in
                    VStack(alignment: .leading) {
                        Text(user.name).font(.headline)
                        Text(user.email).font(.subheadline).foregroundColor(.gray)
                    }
                    .swipeActions {
                        Button(role: .destructive) {
                            Task {
                                await viewModel.deleteUser(id: user.id)
                            }
                        } label: {
                            Label("Eliminar", systemImage: "trash")
                        }

                        Button {
                            // Al asignar el usuario se abre el formulario en modo edición
                            editingUser = user
                        } label: {
                            Label("Editar", systemImage: "pencil")
                        }.tint(.blue)
                    }
                }

                Button {
                    editingUser = nil
                    showingForm = true
                } label: {
                    HStack {
                        Image(systemName: "plus")
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                        Text("Agregar Usuario")
                    }
                }
                .padding()
            }
            .navigationTitle("Usuarios")
            .onAppear {
                Task {
                    await viewModel.fetchUsers()
                }
            }
            // Formulario para agregar un nuevo usuario (POST)
            .sheet(isPresented: $showingForm) {
                UserFormView(name: "", email: "", isEditing: false) { name, email in
                    Task {
                        await viewModel.createUser(name: name, email: email)
                    }
                }
            }
            // Formulario para editar el usuario seleccionado (PUT)
            .sheet(item: $editingUser) { user in
                UserFormView(name: user.name, email: user.email, isEditing: true) { name, email in
                    let updated = User(id: user.id, name: name, email: email)
                    Task {
                        await viewModel.updateUser(user: updated)
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
