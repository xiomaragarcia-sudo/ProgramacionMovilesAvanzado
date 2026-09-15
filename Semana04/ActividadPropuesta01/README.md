# Actividad Propuesta 01 - Sistema Interactivo de Facturación Tecsup

## 📌 Descripción
Sistema de consola interactivo en Swift que solicita los datos del alumno, permite seleccionar cursos desde un catálogo interactivo y genera la factura con desglose de IGV y descuentos.

---

## ⚙️ Requerimientos Funcionales (RF)

* **RF-01: Entrada Interactiva de Alumno**
  * Solicitar por consola mediante `readLine()`: Nombre, DNI y confirmación de alumno Tecsup (S/N).
* **RF-02: Menú de Catálogo de Cursos**
  * Mostrar un catálogo numerado de cursos e inscribir cursos especificando cantidad.
* **RF-03: Cálculos Financieros**
  * Calcular Subtotal, IGV (18%) y Total con IGV acumulado.
* **RF-04: Descuento 10% por Cantidad (≥ 3 cursos)**
  * Aplicar el 10% de descuento sobre el Total con IGV si la suma total de unidades matriculadas es mayor o igual a 3.
* **RF-05: Descuento Especial Tecsup (S/ 400)**
  * Aplicar descuento adicional de S/ 400.00 si es alumno Tecsup Y lleva 3 o más cursos.
* **RF-06: Impresión Estética de Factura**
  * Mostrar el recibo detallado en pantalla con formato ordenado e íconos visuales.