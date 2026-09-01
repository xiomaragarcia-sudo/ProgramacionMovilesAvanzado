let prod1 = "Laptop"
let prec1 = 3500.00
let cant1 = 1
 
let prod2 = "Mouse"
let prec2 = 45.50
let cant2 = 2
 
let prod3 = "Teclado"
let prec3 = 120.00
let cant3 = 1
 
let sub1 = prec1 * Double(cant1)
let sub2 = prec2 * Double(cant2)
let sub3 = prec3 * Double(cant3)
 
let subtotalGeneral = sub1 + sub2 + sub3
let igv = subtotalGeneral * 0.18
let total = subtotalGeneral + igv
 
print("==========================")
print("     FACTURA DE VENTA")
print("==========================")
print("\(prod1) x\(cant1): S/. \(sub1)")
print("\(prod2) x\(cant2): S/. \(sub2)")
print("\(prod3) x\(cant3): S/. \(sub3)")
print("--------------------------")
print("Subtotal: S/. \(subtotalGeneral)")
print("IGV 18%:  S/. \(igv)")
print("TOTAL:    S/. \(total)")
print("==========================")
