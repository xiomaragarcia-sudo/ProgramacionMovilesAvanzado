// 5.3 — Aplicar descuentos con if/else 
// --- TODO 16: Aplica descuento según monto de compra --- 
// Reglas: 
// Compra >= 5000 → 15% de descuento 
// Compra >= 2000 → 10% de descuento 
// Compra >= 500 → 5% de descuento 
// Compra < 500 → sin descuento 

var porcentajeDescuento = 0.0 
if subtotalGeneral >= 5000 { 
    porcentajeDescuento = 0.15 
} else if subtotalGeneral >= 2000 { 
    porcentajeDescuento = 0.10 
} else if subtotalGeneral >= 500 { 
    porcentajeDescuento = 0.05 
} 

let descuento = subtotalGeneral * porcentajeDescuento 
let subtotalConDescuento = subtotalGeneral - descuento