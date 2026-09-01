// 3.2 — Corregir bucles 
// ===== FIX: Encuentra los 2 errores ===== 
// Se quiere imprimir los números pares del 2 al 20: 
for i in 1...20 { 
    if i % 2 == 0 { // FIX 4: Estaba en == 1 (impares). Lo correcto es == 0 para los pares.
        print(i) 
    } 
} 

// Se quiere contar del 10 al 1 (cuenta regresiva): 
// FIX 5: El código original (1...10) contaba hacia adelante. Para ir hacia atrás usamos stride (como indica la pista).
for i in stride(from: 10, through: 1, by: -1) { 
    print(i) 
} 
// Pista: busca "stride" en Swift