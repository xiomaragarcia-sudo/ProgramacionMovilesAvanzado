// Desarrollado por: xiomara garcia
// ===== PREDICT: Predicción de salidas =====

var lista = [1, 2, 3, 4, 5]
lista.remove(at: 0)
lista.append(6)
print(lista)       // PREDICT 1: [2, 3, 4, 5, 6], ya que se borro el primer dato y luego se integro el 6
print(lista.count) // PREDICT 2: 5 , no cambia la cantidad porque se aumento lo que se borro

var nombres = ["Ana", "Carlos", "Beto"]
print(nombres.sorted()) // PREDICT 3: ["Ana", "Beto", "Carlos"] , sorted permite imprimir por orden alfabetico
print(nombres)          // PREDICT 4: ["Ana", "Carlos", "Beto"] , no hay cambios
