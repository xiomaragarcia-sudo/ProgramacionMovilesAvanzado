let nota1 = 15
let nota2 = 12
let nota3 = 18
// FIX 5: faltaban paréntesis para sumar antes de dividir
let promedio = (nota1 + nota2 + nota3) / 3
print("Promedio: \(promedio)")
 
let fahrenheit = 98.6
// FIX 6: faltaban paréntesis en la resta antes de multiplicar/dividir
let celsius = (fahrenheit - 32) * 5 / 9
print("Celsius: \(celsius)")
 
let dividendo = 25
let divisor = 7
// FIX 7: convertir a Double ANTES de dividir para obtener decimales
let resultado = Double(dividendo) / Double(divisor)
print("Resultado: \(resultado)")
