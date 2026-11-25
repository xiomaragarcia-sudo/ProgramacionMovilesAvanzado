//
//  ContentView.swift
//  Semana13_API
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = UserViewModel()

    var body: some View {
        NavigationView {
            VStack {
                // Campo de búsqueda
                TextField("Buscar usuario por nombre", text: $viewModel.searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                // Lista de usuarios filtrados
                List(viewModel.filteredUsers) { user in
                    Text(user.name)
                }
            }
            .navigationTitle("Usuarios")
            .onAppear {
                // Llama a la función fetchUsers() del ViewModel que se encarga de realizar la petición a la API
                viewModel.fetchUsers()
            }
        }
    }
}

#Preview {
    ContentView()
}
