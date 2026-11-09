// 5.6 — Imprimir ticket con bucle 
// --- TODO 19: Imprime el ticket de compra --- 
// Usa un bucle for para imprimir la línea separadora 
// y print con interpolación para los datos 
var separador = "" 
for _ in 1...40 { 
    separador += "=" 
} 

print(separador) 
print(" TICKET DE COMPRA") 
print(" Cliente: \(categoriaCliente)") 
print(separador) 
print("\(prod1) x\(cant1) S/. \(sub1)") 
// TODO: imprime los demás productos
print("\(prod2) x\(cant2) S/. \(sub2)")
print("\(prod3) x\(cant3) S/. \(sub3)")
print("\(prod4) x\(cant4) S/. \(sub4)")
print("\(prod5) x\(cant5) S/. \(sub5)")
print(separador) 
print("Subtotal: S/. \(subtotalGeneral)") 
print("Descuento (\(porcentajeDescuento * 100)%): -S/. \(descuento)") 
print("Subtotal c/desc: S/. \(subtotalConDescuento)") 
print("IGV (18%): S/. \(igv)") 
print(separador) 
print("TOTAL: S/. \(totalFinal)") 
print(separador) 
print("¡Gracias por su compra!")