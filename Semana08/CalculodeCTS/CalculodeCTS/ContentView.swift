//
//  ContentView.swift
//  CalculodeCTS
//
//  Created by Tecsup on 21/10/26.
//

import SwiftUI

struct ContentView: View {
    // Datos de ingreso de usuario
    @State private var sueldoTexto: String = ""
    @State private var gratificacionTexto: String = ""
    @State private var mesesTexto: String = ""
    
    // Resultados
    @State private var montoCTS: Double = 0.0
    @State private var unSextoGrati: Double = 0.0

    var body: some View {
        VStack(spacing: 15) {
            Text("Cálculo de CTS")
                .font(.largeTitle)
                .bold()
            
            // Entradas de texto
            TextField("Sueldo mensual S/.", text: $sueldoTexto)
                .textFieldStyle(.roundedBorder)
                .keyboardType(.decimalPad)
            
            TextField("Gratificación percibida S/.", text: $gratificacionTexto)
                .textFieldStyle(.roundedBorder)
                .keyboardType(.decimalPad)
            
            TextField("Meses trabajados (semestre)", text: $mesesTexto)
                .textFieldStyle(.roundedBorder)
                .keyboardType(.numberPad)
            
            // Botón de cálculo
            Button("Calcular CTS") {
                calcularCTS()
            }
            .buttonStyle(.borderedProminent)
            
            Divider()
                .padding(.vertical, 10)
            
            // Resultados
            VStack(alignment: .leading, spacing: 8) {
                Text("1/6 Gratificación: S/. \(unSextoGrati, specifier: "%.2f")")
                Text("Total CTS: S/. \(montoCTS, specifier: "%.2f")")
                    .font(.title3)
                    .bold()
                    .foregroundColor(.blue)
            }
            Spacer()
        }
        .padding()
    }
    
    // Función de cálculo
    func calcularCTS() {
        let sueldo = Double(sueldoTexto) ?? 0.0
        let gratificacion = Double(gratificacionTexto) ?? 0.0
        let meses = Double(mesesTexto) ?? 0.0
        
        unSextoGrati = gratificacion / 6.0
        let baseCalculo = sueldo + unSextoGrati
        montoCTS = baseCalculo * (meses / 12.0)
    }
}

#Preview {
    ContentView()
}
