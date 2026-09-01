let entero = 42
let decimal = 9.99
let texto = "150"
let textoInvalido = "hola"
 
let enteroADouble = Double(entero)
print(enteroADouble) // 42.0
 
let decimalAEntero = Int(decimal)
print(decimalAEntero) // 9 (trunca, no redondea)
 
let textoAEntero = Int(texto)
print(textoAEntero) // Optional(150)
 
let invalido = Int(textoInvalido)
print(invalido) // nil
