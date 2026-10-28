//
//  PlanillaEngine.swift
//  cts
//
//  Created by Tecsup on 28/10/26.
//

import Foundation

struct PlanillaEngine {
    static let uitVal: Double = 5350.0
    static let rmvVal: Double = 1025.0
    
    static func calcular(instructor: Instructor) -> ResultadoPlanilla {
        // 1. Sueldo Base
        let sueldoBase: Double = instructor.usarSueldoFijo ? instructor.sueldoFijoMensual : (instructor.pagoPorHora * instructor.horasSemanales * 4.0)
        let tarifaHora = instructor.usarSueldoFijo ? (sueldoBase / (instructor.horasSemanales * 4.0)) : instructor.pagoPorHora
        let descuentoFaltas = instructor.horasFaltadas * tarifaHora
        
        // Asignación Familiar: Requiere tener hijos/estudiantes Y NO ser Part-Time (<24h)
        let asignacionFamiliar = (!instructor.esPartTime && instructor.tieneHijosOEstudiante) ? (self.rmvVal * 0.10) : 0.0
        let sueldoBruto = sueldoBase - descuentoFaltas + asignacionFamiliar
        
        // 2. Descuentos del Trabajador
        let descuentoPension = sueldoBruto * instructor.sistemaPension.tasa
        let proyeccionAnual = sueldoBruto * 14.0
        let inafecto7UIT = 7.0 * self.uitVal
        let rentaAfecta = max(0.0, proyeccionAnual - inafecto7UIT)
        let retencion5taMensual = (rentaAfecta * 0.08) / 12.0
        
        let totalDescuentos = descuentoPension + retencion5taMensual
        let sueldoNeto = sueldoBruto - totalDescuentos
        
        // 3. Aporte de la Empresa a EsSalud (9% del Sueldo Bruto)
        let aporteEsSalud = sueldoBruto * 0.09
        
        // 4. Beneficios Sociales
        let (m, d) = instructor.tiempoLaborado
        let mD = Double(m)
        let dD = Double(d)
        
        let gratificacionBase = (sueldoBruto / 6.0) * mD + (sueldoBruto / 180.0) * dD
        let bonoEsSaludGrati = gratificacionBase * 0.09
        let totalGratificacion = gratificacionBase + bonoEsSaludGrati
        
        let unSextoGrati = gratificacionBase / 6.0
        let baseCTS = sueldoBruto + unSextoGrati
        let ctsCalculada = instructor.esPartTime ? 0.0 : ((baseCTS / 12.0) * mD + ((baseCTS / 360.0) * dD))
        
        let vacaciones: Double
        if instructor.esPartTime {
            vacaciones = ((sueldoBruto / 30.0) * 6.0 / 12.0) * mD + ((sueldoBruto / 30.0) * 6.0 / 360.0) * dD
        } else {
            vacaciones = (sueldoBruto / 12.0) * mD + (sueldoBruto / 360.0) * dD
        }
        
        return ResultadoPlanilla(
            sueldoBase: sueldoBase,
            descuentoFaltas: descuentoFaltas,
            asignacionFamiliar: asignacionFamiliar,
            sueldoBruto: sueldoBruto,
            descuentoPension: descuentoPension,
            retencion5ta: retencion5taMensual,
            totalDescuentos: totalDescuentos,
            sueldoNeto: sueldoNeto,
            aporteEsSalud: aporteEsSalud,
            gratificacionBase: gratificacionBase,
            bonoEsSaludGrati: bonoEsSaludGrati,
            gratificacionTotal: totalGratificacion,
            ctsTotal: ctsCalculada,
            vacacionesTotal: vacaciones
        )
    }
}
