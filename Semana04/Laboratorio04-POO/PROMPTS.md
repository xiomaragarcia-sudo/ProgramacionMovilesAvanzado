# Prompts utilizados – Laboratorio 04

## Herramienta de IA utilizada
Gemini 

## Caso 2B – Biblioteca

### Prompt 1:
"Soy estudiante de Swift, cuarta semana, trabajo en un Playground de Xcode. Necesito una biblioteca con enum EstadoLibro, struct Libro y class Biblioteca con prestar, devolver e inventario. Solo usar struct, class, herencia, protocolos, enums, arrays, bucles y funciones. Sin optionals ni guard let, sin firstIndex(where:), sin didSet, sin propiedades calculadas, sin genéricos. Solo el código Swift, con las firmas exactas que te indico. La salida debe ser idéntica a: Préstamo aprobado: La ciudad y los perros, Error: La ciudad y los perros ya está prestado, Devolución registrada: La ciudad y los perros, Préstamo aprobado: El Quijote, Error: no existe El Principito."

### Respuesta de la IA:
La IA generó el código completo definiendo el `enum EstadoLibro`, la `struct Libro` y la `class Biblioteca` usando un bucle `for i in 0..<libros.count` para recorrer el arreglo por índice y modificar el estado directamente.

### ¿Funcionó a la primera?
Sí, funcionó a la primera respetando las restricciones de no usar métodos avanzados ni opcionales.

### ¿Usó algo que no hemos visto en clase?
No, se restringió a bucles `for-in`, `switch` y manipulación directa de arreglos.

## Mi versión (Parte A) vs. la versión de la IA (Parte B)

### ¿Qué hizo distinto la IA respecto a mi solución?
Ambas soluciones resultaron muy parecidas debido a las restricciones estrictas del prompt, utilizando el recorrido por índice para poder modificar el estado del struct dentro del array.

### ¿Hay alguna línea de la IA que no entiendo del todo? ¿Cuál?
No, toda la sintaxis empleada corresponde a bucles básicos, condicionales `if` y estructuras `switch`.

### ¿Qué me pareció mejor de MI versión?
La claridad en la estructura y que fue escrita paso a paso entendiendo la lógica de referencia vs valor.

### ¿Qué me pareció mejor de la versión de la IA?
La rapidez para generar la plantilla completa con la salida requerida de forma exacta.