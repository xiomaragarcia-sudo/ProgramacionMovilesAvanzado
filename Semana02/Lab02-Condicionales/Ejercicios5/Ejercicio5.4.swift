// 5.4 — Categorizar cliente con switch 
// --- TODO 17: Categoría de cliente según monto --- 
// Usa switch con rangos para determinar la categoría: 
// 0 - 499: "Regular" 
// 500 - 1999: "Frecuente" 
// 2000 - 4999: "VIP" 
// 5000+: "Premium" 

let montoParaCategoria = Int(subtotalGeneral) 
var categoriaCliente = "" 
switch montoParaCategoria { 
case 0..<500: categoriaCliente = "Regular" 
case 500..<2000: categoriaCliente = "Frecuente" 
case 2000..<5000: categoriaCliente = "VIP" 
default: categoriaCliente = "Premium" 
}