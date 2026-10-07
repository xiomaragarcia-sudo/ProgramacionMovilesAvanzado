# PROMPTS.md - Ejercicio 4

## Prompt 1
CONTEXTO: Soy estudiante de iOS con UIKit y Storyboard (Swift). Hasta ahora he visto
clases, UINavigationController, prepare(for:sender:) e IBOutlet/IBAction.
TAREA: Calculadora de venta a plazos de electrodomésticos con dos pantallas:
"Nueva Venta" (5 UITextField: electrodoméstico, precio, cantidad, meses, interés
mensual %) y "Resultado" (6 UILabel).
1. Define class VentaModel: NSObject con 6 propiedades Double: subtotal, igv, base,
   intereses, total, cuota.
2. En Nueva Venta calcula: subtotal = precio*cantidad; igv = subtotal*0.18;
   base = subtotal+igv; intereses = base*(tasa/100)*meses; total = base+intereses;
   cuota = total/meses. Arma un VentaModel.
3. Pásalo a Resultado con prepare(for:sender:) (segue "showResultado").
4. En Resultado muestra cada valor con String(format: "S/. %.2f", valor).
RESTRICCIONES: Solo clases, UINavigationController, prepare(for:sender:),
IBOutlet/IBAction. Nada de Combine, Codable ni persistencia.
Explica por qué VentaModel es class y no struct.
FORMATO: Un bloque de código por archivo, con comentarios breves.

## Resultado
Código generado para VentaModel, NuevaVentaViewController y ResultadoViewController.

## Verificación
Probé precio 3500, cantidad 1, meses 12, interés 1% y obtuve total S/. 4625.60 y
cuota S/. 385.47, que coincide con las fórmulas.

## ¿Por qué class y no struct?
Una class es un tipo por referencia: al pasar el objeto por prepare(for:sender:)
ambas pantallas trabajan con la misma instancia. Un struct se copia al asignarlo,
y los cambios hechos en una pantalla no se verían en la otra (lo visto en el
PREDICT del Ejercicio 2). Además, NSObject solo se puede heredar en clases.
