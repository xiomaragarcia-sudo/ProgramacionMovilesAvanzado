# Actividad Propuesta 01 - Facturación de Cursos Libres Tecsup

## 📌 Descripción del Problema
La institución Tecsup requiere un sistema en Swift para calcular el monto de facturación de la inscripción de alumnos en cursos libres, aplicando descuentos según la cantidad de cursos y la afiliación del estudiante.

---

## ⚙️ Requerimientos Funcionales (RF)

* **RF-01: Registro del Estudiante**
  * El sistema debe registrar los datos básicos del estudiante: Nombre, DNI y condición de Alumno Tecsup (Booleano: `true`/`false`).

* **RF-02: Registro e Inserción de Cursos**
  * El sistema debe permitir registrar una lista de cursos matriculados especificando: Nombre del curso, cantidad comprada y precio unitario (o precio total acumulado).

* **RF-03: Cálculo de Subtotal e IGV**
  * El sistema debe calcular el **Subtotal** sumando los costos individuales de los cursos matriculados.
  * El sistema debe calcular el **IGV (18%)** correspondiente al Subtotal.
  * El sistema debe calcular el **Total con IGV** (`Subtotal + IGV`).

* **RF-04: Aplicación de Descuento por Cantidad de Cursos**
  * El sistema debe verificar la cantidad total de cursos adquiridos (suma de unidades/cantidades de todos los cursos).
  * Si la cantidad total es **3 o más cursos**, se aplica un descuento del **10% sobre el Total con IGV**.

* **RF-05: Aplicación de Descuento Especial Alumno Tecsup**
  * Si el estudiante es **Alumno Tecsup (`true`)** Y la cantidad total de cursos es **3 o más**, se aplica un descuento fijo adicional de **S/ 400.00**.

* **RF-06: Impresión de Factura Resumen**
  * El sistema debe imprimir en consola una representación visual tipo factura con los datos del alumno, el detalle de cursos, subtotal, IGV, descuentos aplicados (con indicador `✓`) y el **Total Final a Pagar**.