
# Sistema de Información - Metro de Lima

Aplicación de consola en Swift que permite a los usuarios consultar información 
sobre las líneas, estaciones y conexiones del Metro de Lima con el Metropolitano.

## Requerimientos Funcionales

1. **RF01 - Consultar estaciones por línea**: El sistema debe permitir al usuario 
   ingresar el nombre de una línea (Línea 1, Línea 2 o Línea 3) y mostrar la lista 
   completa de estaciones que la componen, en orden de recorrido.

2. **RF02 - Consultar información detallada de una estación**: El sistema debe 
   permitir buscar una estación por nombre y devolver:
   - La línea a la que pertenece
   - Si cuenta con ascensor (accesibilidad)
   - Las vías/avenidas cercanas a la estación
   - Si tiene conexión directa con el Metropolitano

3. **RF03 - Consultar conexiones con el Metropolitano**: El sistema debe listar 
   todas las estaciones del Metro que tienen conexión con alguna estación del 
   Metropolitano, indicando el nombre de la estación de enlace.

4. **RF04 - Búsqueda flexible (tolerante a formato de entrada)**: El sistema debe 
   reconocer la entrada del usuario sin importar mayúsculas/minúsculas, tildes o 
   espacios (ej. "linea2", "Línea 2" y "LINEA 2" deben dar el mismo resultado).

5. **RF05 - Menú interactivo por consola**: El sistema debe presentar un menú 
   principal con las opciones disponibles, permitir al usuario elegir una acción 
   repetidamente hasta que decida salir, y validar entradas no reconocidas sin 
   detener el programa.

## Estructura de datos utilizada

- **31 estaciones reales y operativas**: 26 de Línea 1 + 5 de Línea 2.
- **28 estaciones del proyecto Línea 3** (aún no construida, datos oficiales del MTC/ATU).
- 4 diccionarios (`estacionesPorLinea`, `detalleEstaciones`, `conexionesMetropolitano`, 
  además de los diccionarios normalizados para búsqueda flexible).
- 1 struct (`Estacion`) para modelar los datos de cada estación.


## Fuente de datos
Estaciones y conexiones basadas en información pública del Metro de Lima y Callao 
(Línea 1 y Línea 2 operativas) y del proyecto oficial de Línea 3 (ATU/MTC). Los datos 
de accesibilidad (ascensores) y vías cercanas son simulados con fines académicos, ya 
que no existe una base de datos pública detallada por estación.

## Herramienta de IA utilizada
[Claude]
