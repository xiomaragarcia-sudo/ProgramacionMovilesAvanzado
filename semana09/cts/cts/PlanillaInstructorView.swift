//
//  PlanillaInstructorView.swift
//  cts
//
//  Created by Tecsup on 28/10/26.
//

import SwiftUI

struct PlanillaInstructorView: View {
    @State private var instructor = Instructor()
    
    var resultado: ResultadoPlanilla {
        PlanillaEngine.calcular(instructor: instructor)
    }
    
    var body: some View {
        NavigationView {
            Form {
                // Sección Datos del Instructor
                Section(header: Text("DATOS DEL INSTRUCTOR").fontWeight(.bold)) {
                    HStack {
                        Image(systemName: "person.fill").foregroundColor(.blue)
                        TextField("Nombre completo", text: $instructor.nombre)
                    }
                    
                    DatePicker("Fecha de Ingreso", selection: $instructor.fechaIngreso, displayedComponents: .date)
                    DatePicker("Fecha de Cálculo", selection: $instructor.fechaCorte, displayedComponents: .date)
                    
                    HStack {
                        Text("Tiempo Laborado")
                        Spacer()
                        let (m, d) = instructor.tiempoLaborado
                        Text("\(m) meses, \(d) días")
                            .font(.caption)
                            .fontWeight(.semibold)
                            .padding(6)
                            .background(Color.blue.opacity(0.1))
                            .cornerRadius(6)
                    }
                    
                    // Toggle Asignación Familiar
                    Toggle(isOn: $instructor.tieneHijosOEstudiante) {
                        VStack(alignment: .leading, spacing: 2) {
                            Text("¿Tiene Hijos Menores o Estudiantes?")
                                .font(.body)
                            Text("Aplica si tiene hijos <18 años o estudiantes hasta 24 años (Ley 25129)")
                                .font(.caption2)
                                .foregroundColor(.gray)
                        }
                    }
                    
                    Picker("Modalidad de Ingreso", selection: $instructor.usarSueldoFijo) {
                        Text("Por Horas").tag(false)
                        Text("Sueldo Fijo Mensual").tag(true)
                    }
                    .pickerStyle(.segmented)
                    .padding(.vertical, 4)
                    
                    if instructor.usarSueldoFijo {
                        HStack {
                            Text("Sueldo Fijo Mensual (S/)")
                            Spacer()
                            TextField("S/", value: $instructor.sueldoFijoMensual, format: .currency(code: "PEN"))
                                .keyboardType(.decimalPad)
                                .multilineTextAlignment(.trailing)
                                .fontWeight(.bold)
                                .foregroundColor(.blue)
                        }
                    } else {
                        HStack {
                            Text("Pago por Hora (S/)")
                            Spacer()
                            TextField("S/", value: $instructor.pagoPorHora, format: .currency(code: "PEN"))
                                .keyboardType(.decimalPad)
                                .multilineTextAlignment(.trailing)
                        }
                    }
                    
                    HStack {
                        Text("Horas Semanales Dictadas")
                        Spacer()
                        TextField("Horas", value: $instructor.horasSemanales, format: .number)
                            .keyboardType(.numberPad)
                            .multilineTextAlignment(.trailing)
                    }
                    
                    HStack {
                        Text("Régimen Laboral")
                        Spacer()
                        Text(instructor.esPartTime ? "Part-Time (<24h)" : "Tiempo Completo (≥24h)")
                            .font(.caption)
                            .fontWeight(.bold)
                            .foregroundColor(instructor.esPartTime ? .orange : .green)
                    }
                    
                    HStack {
                        Text("Faltas/Tardanzas (Horas)")
                        Spacer()
                        TextField("Horas", value: $instructor.horasFaltadas, format: .number)
                            .keyboardType(.numberPad)
                            .multilineTextAlignment(.trailing)
                    }
                    
                    Picker("Sistema de Pensión", selection: $instructor.sistemaPension) {
                        ForEach(SistemaPension.allCases) { pension in
                            Text(pension.rawValue).tag(pension)
                        }
                    }
                }
                
                // Sección Cálculo Mensual
                Section(header: Text("CÁLCULO MENSUAL").fontWeight(.bold)) {
                    LabeledContent("Sueldo Base", value: resultado.sueldoBase, format: .currency(code: "PEN"))
                    
                    if resultado.descuentoFaltas > 0 {
                        LabeledContent("(-) Descuento Faltas", value: resultado.descuentoFaltas, format: .currency(code: "PEN"))
                            .foregroundColor(.red)
                    }
                    
                    HStack {
                        Text("(+) Asignación Familiar")
                        Spacer()
                        if instructor.esPartTime && instructor.tieneHijosOEstudiante {
                            Text("S/ 0.00 (No aplica PT)")
                                .font(.caption)
                                .foregroundColor(.gray)
                        } else {
                            Text(resultado.asignacionFamiliar, format: .currency(code: "PEN"))
                        }
                    }
                    
                    LabeledContent("Sueldo Bruto Mensual", value: resultado.sueldoBruto, format: .currency(code: "PEN"))
                        .fontWeight(.semibold)
                    
                    LabeledContent("(-) Retención Pensión", value: resultado.descuentoPension, format: .currency(code: "PEN"))
                    LabeledContent("(-) Impuesto Renta 5ta Cat.", value: resultado.retencion5ta, format: .currency(code: "PEN"))
                    
                    HStack {
                        Text("SUELDO NETO A COBRAR")
                            .font(.headline)
                        Spacer()
                        Text(resultado.sueldoNeto, format: .currency(code: "PEN"))
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(.green)
                    }
                    .padding(.vertical, 4)
                }
                
                // Sección Aportes Empleador (EsSalud)
                Section(header: Text("APORTES DEL EMPLEADOR").fontWeight(.bold)) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text("EsSalud (9%)")
                                .fontWeight(.semibold)
                            Text("Aporte asumido 100% por la empresa")
                                .font(.caption2)
                                .foregroundColor(.gray)
                        }
                        Spacer()
                        Text(resultado.aporteEsSalud, format: .currency(code: "PEN"))
                            .fontWeight(.bold)
                            .foregroundColor(.blue)
                    }
                }
                
                // Sección Beneficios Sociales
                Section(header: Text("BENEFICIOS SOCIALES GENERADOS").fontWeight(.bold)) {
                    LabeledContent("Gratificación Base", value: resultado.gratificacionBase, format: .currency(code: "PEN"))
                    LabeledContent("(+) Bono Extraordinario EsSalud (9%)", value: resultado.bonoEsSaludGrati, format: .currency(code: "PEN"))
                        .foregroundColor(.blue)
                    LabeledContent("TOTAL GRATIFICACIÓN", value: resultado.gratificacionTotal, format: .currency(code: "PEN"))
                        .fontWeight(.semibold)
                    
                    HStack {
                        Text("CTS A Depositar")
                        Spacer()
                        if instructor.esPartTime {
                            Text("S/ 0.00 (No aplica PT)")
                                .font(.caption)
                                .foregroundColor(.gray)
                        } else {
                            Text(resultado.ctsTotal, format: .currency(code: "PEN"))
                        }
                    }
                    
                    LabeledContent("Vacaciones Proporcionales", value: resultado.vacacionesTotal, format: .currency(code: "PEN"))
                }
            }
            .navigationTitle("Planilla Instructores")
        }
    }
}
