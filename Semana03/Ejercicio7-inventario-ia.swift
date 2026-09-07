// Desarrollado por: xiomara garcia
import Foundation // Importa el módulo Foundation para la ejecución del programa
var precios: [String: Double] = [:] // Diccionario para almacenar los precios usando el nombre como clave
var stocks: [String: Int] = [:] // Diccionario para almacenar la cantidad en stock usando el nombre como clave
print("¿Cuántos productos registrará inicialmente?") // Solicita la cantidad inicial de productos
let cantidadProductos = Int(readLine() ?? "") ?? 0 // Lee e interpreta la cantidad ingresada
if cantidadProductos > 0 { // Verifica que la cantidad de productos sea mayor a cero
    for i in 1...cantidadProductos { // Bucle para pedir los datos de cada producto
        print("\nProducto \(i) - Nombre:") // Solicita el nombre del producto
        let nombre = readLine() ?? "" // Lee la variable nombre del teclado
        print("Precio:") // Solicita el precio del producto
        let precio = Double(readLine() ?? "") ?? 0.0 // Lee el precio y lo convierte a Double
        print("Stock:") // Solicita la cantidad en stock
        let stock = Int(readLine() ?? "") ?? 0 // Lee el stock y lo convierte a Int
        precios[nombre] = precio // Guarda el precio en el diccionario de precios
        stocks[nombre] = stock // Guarda el stock en el diccionario de stocks
    } // Fin del bucle de registro inicial
} // Fin de la condición inicial
var opcion = 0 // Variable de control para la opción seleccionada en el menú
while opcion != 5 { // Bucle principal del menú que se ejecuta hasta seleccionar la opción 5
    print("\n===== MENÚ DE INVENTARIO =====") // Muestra el título del menú
    print("1) Ver inventario") // Muestra la opción 1
    print("2) Buscar producto") // Muestra la opción 2
    print("3) Stock bajo (< 5)") // Muestra la opción 3
    print("4) Valor total del inventario") // Muestra la opción 4
    print("5) Salir") // Muestra la opción 5
    print("Seleccione una opción:") // Solicita al usuario elegir una opción
    opcion = Int(readLine() ?? "") ?? 0 // Lee la opción ingresada por el usuario
    switch opcion { // Evalúa la opción seleccionada mediante switch
    case 1: // Opción 1: Ver inventario completo
        print("\n--- INVENTARIO COMPLETO ---") // Encabezado de la lista
        for (nombre, precio) in precios { // Recorre los productos almacenados
            let stock = stocks[nombre] ?? 0 // Obtiene el stock correspondiente al producto
            print("Producto: \(nombre) | Precio: S/. \(precio) | Stock: \(stock) unidades") // Imprime los detalles del producto
        } // Fin del bucle de visualización
    case 2: // Opción 2: Buscar un producto por nombre
        print("\nIngrese el nombre del producto a buscar:") // Pide la clave a buscar
        let buscar = readLine() ?? "" // Lee el texto ingresado
        if let precio = precios[buscar], let stock = stocks[buscar] { // Verifica si el producto existe
            print("Encontrado: \(buscar) | Precio: S/. \(precio) | Stock: \(stock) unidades") // Muestra la información encontrada
        } else { // Si el producto no existe en el diccionario
            print("El producto '\(buscar)' no se encuentra en el inventario.") // Mensaje de producto no hallado
        } // Fin de la verificación de búsqueda
    case 3: // Opción 3: Filtrar productos con stock menor a 5
        print("\n--- PRODUCTOS CON STOCK BAJO (< 5) ---") // Encabezado de reporte de stock bajo
        for (nombre, stock) in stocks { // Recorre el diccionario de stocks
            if stock < 5 { // Filtra solo los productos con menos de 5 unidades
                let precio = precios[nombre] ?? 0.0 // Obtiene el precio asociado
                print("Alerta: \(nombre) | Stock: \(stock) | Precio: S/. \(precio)") // Muestra la alerta de stock bajo
            } // Fin de la condición de stock bajo
        } // Fin del bucle de filtrado
    case 4: // Opción 4: Calcular el valor total monetario del inventario
        var total = 0.0 // Variable acumuladora del valor total
        for (nombre, precio) in precios { // Recorre todos los precios
            let stock = stocks[nombre] ?? 0 // Recupera la cantidad en stock de cada producto
            total += precio * Double(stock) // Suma el resultado de multiplicar precio por stock
        } // Fin del cálculo de acumulación
        print("\nValor total del inventario: S/. \(total)") // Muestra el resultado final del valor total
    case 5: // Opción 5: Finalizar el programa
        print("\nSaliendo del sistema de inventario...") // Mensaje de salida del programa
    default: // Manejo de opción inválida
        print("\nOpción inválida. Intente nuevamente.") // Mensaje de error para opción no válida
    } // Fin de la estructura switch
} // Fin del bucle while principal