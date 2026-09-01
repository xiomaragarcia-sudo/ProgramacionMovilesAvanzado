// ===== PROBLEMA A: CALCULADORA DE IMC =====
// Datos de 3 personas: nombre, peso (kg) y estatura (m)
let persona1 = "Xiomara"          // Nombre de la primera persona
let peso1 = 58.0                   // Peso en kilogramos de la persona 1
let estatura1 = 1.51               // Estatura en metros de la persona 1

let persona2 = "Carlos"            // Nombre de la segunda persona
let peso2 = 80.0                   // Peso en kilogramos de la persona 2
let estatura2 = 1.75               // Estatura en metros de la persona 2

let persona3 = "Ana"               // Nombre de la tercera persona
let peso3 = 65.0                   // Peso en kilogramos de la persona 3
let estatura3 = 1.60               // Estatura en metros de la persona 3

// Calcula el IMC de cada persona con la fórmula: peso / (estatura * estatura)
let imc1 = peso1 / (estatura1 * estatura1)   // IMC de la persona 1
let imc2 = peso2 / (estatura2 * estatura2)   // IMC de la persona 2
let imc3 = peso3 / (estatura3 * estatura3)   // IMC de la persona 3

// Función que recibe un IMC y devuelve el texto de la categoría correspondiente
func categoriaIMC(_ imc: Double) -> String {
    if imc < 18.5 {                          // Si el IMC es menor a 18.5
        return "Bajo peso"                   // Categoría: bajo peso
    } else if imc < 25.0 {                   // Si el IMC está entre 18.5 y 24.9
        return "Normal"                      // Categoría: normal
    } else if imc < 30.0 {                   // Si el IMC está entre 25 y 29.9
        return "Sobrepeso"                   // Categoría: sobrepeso
    } else {                                 // Si el IMC es 30 o más
        return "Obesidad"                    // Categoría: obesidad
    }
}

// Imprime la tabla con nombre, IMC y categoría de cada persona
print("========== TABLA DE IMC ==========")                                   // Encabezado de la tabla
print("\(persona1): IMC = \(imc1) — \(categoriaIMC(imc1))")                    // Fila persona 1
print("\(persona2): IMC = \(imc2) — \(categoriaIMC(imc2))")                    // Fila persona 2
print("\(persona3): IMC = \(imc3) — \(categoriaIMC(imc3))")                    // Fila persona 3
print("===================================")                                   // Cierre de la tabla