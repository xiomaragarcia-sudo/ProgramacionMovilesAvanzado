// ===== FIX: Este código tiene 4 errores. Encuéntralos y corrígelos =====
//Docente: Juan León
 
// FIX 1: 'puntaje' se declaró como constante (let) pero se reasigna. Debe ser var.
var puntaje = 50
puntaje = 80
 
// FIX 2: 'nombre' ya es var, no se vuelve a declarar con 'var' para cambiar su valor.
var nombre = "Ana"
nombre = "María"
 
// FIX 3: 29.99 tiene decimales, el tipo debe ser Double, no Int.
let precio: Double = 29.99
 
// FIX 4: 'true' con comillas es un String. Un Bool va sin comillas.
var activo: Bool = true
