//
//  PendienteView.swift
//  Compras
//
//  Created by Tecsup on 9/11/26.
//

import SwiftUI

struct PendienteView: View {
    let titulo: String

    var body: some View {
        NavigationStack {
            ContentUnavailableView("En construcción",
                                   systemImage: "hammer",
                                   description: Text("Esta pantalla se agrega en un siguiente commit."))
                .navigationTitle(titulo)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) { AvatarMenu() }
                }
        }
    }
}
