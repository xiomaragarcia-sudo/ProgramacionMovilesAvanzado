import Foundation

// Variables sueltas y directas
var deudaTotal = 3500.0
let cuotas = 12
let pagoMensual = deudaTotal / Double(cuotas)

// Configurar fecha de manera manual
let formatoFecha = DateFormatter()
formatoFecha.dateFormat = "dd/MM/yyyy"
var fechaActual = formatoFecha.date(from: "25/09/2026")!

// Imprimir cabecera con tabulaciones
print("Mes\t| Fecha\t\t| Monto Inicial\t| Pago\t\t| Saldo")
print("-------------------------------------------------------------------")

// Bucle principal
for i in 1...cuotas {
    var pago = pagoMensual
    
    // Lógica directa para el abono extra en el mes 3
    if i == 3 {
        pago = pago + 1000.0
    }
    
    // Evitar saldo negativo si se paga de más
    if pago > deudaTotal {
        pago = deudaTotal
    }
    
    let saldoInicial = deudaTotal
    deudaTotal = deudaTotal - pago
    
    let fechaString = formatoFecha.string(from: fechaActual)
    
    let iniStr = String(format: "%.2f", saldoInicial)
    let pagoStr = String(format: "%.2f", pago)
    let saldoStr = String(format: "%.2f", deudaTotal)
    
    print("\(i)\t| \(fechaString)\t| \(iniStr)\t| \(pagoStr)\t| \(saldoStr)")
    
    // Sumar un mes de forma directa
    fechaActual = Calendar.current.date(byAdding: .month, value: 1, to: fechaActual)!
    
    if deudaTotal <= 0 {
        break
    }
}
