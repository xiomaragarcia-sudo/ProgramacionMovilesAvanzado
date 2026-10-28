//
//  Instructor.swift
//  cts
//
//  Created by Tecsup on 28/10/26.
//

import Foundation

enum SistemaPension: String, CaseIterable, Identifiable {
    case onp = "ONP (13%)"
    case afp = "AFP (11.7%)"
    
    var id: String { self.rawValue }
    var tasa: Double {
        switch self {
        case .onp: return 0.13
        case .afp: return 0.117
        }
    }
}

struct Instructor {
    var nombre: String = "Prof. Juan Carlos Pérez"
    var fechaIngreso: Date = Calendar.current.date(byAdding: .month, value: -6, to: Date()) ?? Date()
    var fechaCorte: Date = Date()
    
    var usarSueldoFijo: Bool = false
    var sueldoFijoMensual: Double = 4000.0
    var pagoPorHora: Double = 50.0
    var horasSemanales: Double = 20.0
    var horasFaltadas: Double = 0.0
    
    // Condición para Asignación Familiar (Hijos menores o estudiantes hasta 24 años)
    var tieneHijosOEstudiante: Bool = false
    
    var sistemaPension: SistemaPension = .onp
    
    var esPartTime: Bool {
        return horasSemanales < 24.0
    }
    
    var tiempoLaborado: (meses: Int, dias: Int) {
        let calendar = Calendar.current
        let comp = calendar.dateComponents([.month, .day], from: fechaIngreso, to: fechaCorte)
        return (max(0, comp.month ?? 0), max(0, comp.day ?? 0))
    }
}

struct ResultadoPlanilla {
    let sueldoBase: Double
    let descuentoFaltas: Double
    let asignacionFamiliar: Double
    let sueldoBruto: Double
    let descuentoPension: Double
    let retencion5ta: Double
    let totalDescuentos: Double
    let sueldoNeto: Double
    let aporteEsSalud: Double          // Aporte Empleador 9%
    let gratificacionBase: Double
    let bonoEsSaludGrati: Double       // Bonificación 9% EsSalud en Grati
    let gratificacionTotal: Double
    let ctsTotal: Double
    let vacacionesTotal: Double
}
