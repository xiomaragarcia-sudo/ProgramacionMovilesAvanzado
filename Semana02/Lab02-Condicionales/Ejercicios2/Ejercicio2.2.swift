// 2.2 — Predicciones 
// PREDICT: ¿Qué imprime? 
let mes = 2 
switch mes { 
case 1, 3, 5, 7, 8, 10, 12: print("31 días") 
case 4, 6, 9, 11: print("30 días") 
case 2: print("28 o 29 días") 
default: print("Mes inválido") 
} // PREDICT 4: "28 o 29 días" 

let letra: Character = "a" 
switch letra { 
case "a", "e", "i", "o", "u": print("Vocal") 
default: print("Consonante") 
} // PREDICT 5: "Vocal"