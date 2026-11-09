// 1.2 — Corregir errores 
// ===== FIX: Encuentra y corrige los 3 errores ===== 
let temperatura = 35 
if temperatura > 30 { 
    print("Hace calor") 
} else if temperatura > 20 { // ERROR 1: Faltaba la llave de apertura "{" aquí
    print("Clima agradable") 
} else { 
    print("Hace frío") 
} 

let saldo = 100.0 
let compra = 150.0 
if saldo >= compra { // ERROR 2: Lógicamente debería ser ">=" para permitir compras si el saldo es exacto.
    print("Compra realizada") 
} else { 
    // ERROR 3: Era (saldo - compra), lo que daría un resultado negativo (-50.0). Lo correcto es (compra - saldo).
    print("Saldo insuficiente: te faltan \(compra - saldo)") 
} 

let hora = 25 
if hora >= 0 && hora < 12 { 
    print("Buenos días") 
} else if hora >= 12 && hora < 18 { 
    print("Buenas tardes") 
} else if hora >= 18 && hora <= 23 { 
    print("Buenas noches") 
} else { 
    print("Hora inválida") 
}