//
//  ContentView.swift
//  demostracion
//
//  Created by Tecsup on 21/10/26.
//

import SwiftUI

struct ContentView: View {
    //datos de ingreso de usuario
    @State private var nombre: String = ""
    @State private var precioTexto: String = ""
    @State private var descuentoTexto: String = ""
    //resultados
    @State private var subtotal: Double = 0.0
    @State private var igv: Double = 0.0
    @State private var total: Double = 0.0
    @State private var descuento: Double = 0.0
    //igv
    let tasaIGV = 0.18
    var body: some View {
        VStack (spacing:15){
            Text("Venta de Productos")
                .font(Font.largeTitle)
                .bold(true)
            //entradas
            TextField("Nombre del producto",text: $nombre)
                .textFieldStyle(.roundedBorder)
            TextField("Precio S/.  " , text: $precioTexto )
                .textFieldStyle(.roundedBorder)
                .keyboardType(.decimalPad)
            TextField("Descuento s/.  ", text: $descuentoTexto)
                .textFieldStyle(.roundedBorder)
                .keyboardType(.decimalPad)
            Button("Calcular"){
                //llamar funcion
                calcular()
            }
            Text("Producto : \(nombre)")
            Text("Descuento : \(descuento,specifier: "%.2f")")
        }
    }
    func calcular(){
        //operaciones
        let precio = Double (precioTexto) ?? 0
        let porcentaje = Double(descuentoTexto) ?? 0
        descuento = (precio * (porcentaje / 100))
        subtotal = precio - descuento
        igv = (subtotal * tasaIGV)
        total = subtotal + igv
    }
}
    
#Preview {
    ContentView()
}
