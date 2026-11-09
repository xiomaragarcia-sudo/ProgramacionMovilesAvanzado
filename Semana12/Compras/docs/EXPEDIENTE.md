# Expediente · Trabajo Grupo B · Caso Compras

| | |
|---|---|
| **Curso** | Programación de Aplicaciones Móviles Avanzado · Tecsup |
| **Semana** | 12 |
| **Caso** | Grupo B · Compras de una distribuidora |
| **Tecnología** | SwiftUI + SwiftData (iOS 17 o superior) · Swift Charts para el Kardex |
| **Integrante** | Xiomara García |
| **Repositorio** | `ProgramacionMovilesAvanzado/Semana12/Compras` |

**Objetivo:** una app de empresa en la que el **Comprador** registra compras a proveedores, al contado o a crédito, y el **Supervisor** aprueba las compras grandes, paga las cuentas por pagar y revisa el resumen. La app calcula el IGV como crédito fiscal y el costo promedio ponderado del inventario.

---

## 1. Entidades y atributos (4 clases `@Model`)

| Clase | Atributo | Tipo | Notas |
|---|---|---|---|
| **Usuario** | nombre | String | Nombre completo |
| | usuario | String | Único; se guarda en minúsculas para que la comparación no distinga mayúsculas |
| | clave | String | Mínimo 6 caracteres; se guarda como hash SHA-256, no en texto plano |
| | rol | String | `"Comprador"` o `"Supervisor"` |
| **Proveedor** | nombre | String | |
| | ruc | String | 11 dígitos |
| **Producto** | nombre, categoria | String | |
| | stock | Int | Unidades en almacén |
| | costoPromedio | Double | Costo unitario promedio, sin IGV |
| | stockMinimo ★ | Int | **Agregado (Kardex).** Por defecto, 5 |
| **Compra** | fecha | Date | Día en que se registró |
| | cantidad | Int | Mayor que 0 |
| | costoUnitario, igv, total | Double | Sin IGV · 18 % · subtotal + IGV |
| | alCredito | Bool | `false` = contado · `true` = crédito a 30 días |
| | vence | Date | fecha + 30 días (si es al contado, igual a la fecha) |
| | estado | String | `"Pendiente"`, `"Aprobada"` o `"Rechazada"` |
| | pagada | Bool | |
| | motivoRechazo | String? | Obligatorio al rechazar |
| | stockDespues ★, costoPromedioDespues ★ | Int?, Double? | **Agregado (Kardex).** Se guardan al aprobar la compra |

★ Atributos agregados para la función extra (sección 8). Los atributos que pide el enunciado no cambian.

**Atributos calculados (no se guardan):**
- `Compra.subtotal` = cantidad × costoUnitario
- `Compra.estaVencida` = alCredito ∧ ¬pagada ∧ estado = Aprobada ∧ vence < hoy
- `Producto.valorInventario` = stock × costoPromedio

## 2. Relaciones y reglas de borrado

```
Usuario   1 ──── * Compra   (Usuario.compras,   deleteRule: .deny, inverse: \Compra.comprador)
Proveedor 1 ──── * Compra   (Proveedor.compras, deleteRule: .deny, inverse: \Compra.proveedor)
Producto  1 ──── * Compra   (Producto.compras,  deleteRule: .deny, inverse: \Compra.producto)
```

- **`.deny`:** no se puede borrar un usuario, un proveedor ni un producto que tenga compras. Además de la regla del modelo, la app lo valida antes de borrar (`compras.isEmpty`). Si tiene compras, muestra la alerta *"No se puede borrar: tiene N compra(s) registrada(s)"* y no borra nada.
- Del lado de **Compra**, las referencias `comprador`, `proveedor` y `producto` son opcionales (`?`), como pide SwiftData para las relaciones inversas.
- Cada compra guarda **quién la registró**: `comprador` es el usuario que tiene la sesión abierta.

## 3. Matriz de permisos por rol

| Acción | Comprador | Supervisor |
|---|:---:|:---:|
| Pestañas | Productos · Proveedores · Compra · Mis compras | Resumen · Aprobar · Por pagar · Productos · Proveedores |
| Ver y buscar productos y proveedores | ✅ | ✅ |
| Crear, editar y borrar productos y proveedores (botón +, deslizar) | ❌ | ✅ |
| Registrar una compra | ✅ | ❌ |
| Ver compras | Solo las suyas | Todas |
| Aprobar o rechazar compras pendientes | ❌ | ✅ |
| Pagar una compra a crédito (deslizar Pagar) | ❌ | ✅ |
| Ver el Resumen | ❌ | ✅ |
| Ver el Kardex de un producto ★ | ✅ (solo consulta) | ✅ (y editar el stock mínimo) |
| Menú del avatar con nombre, rol y Cerrar sesión | ✅ | ✅ |

## 4. Reglas de negocio con ejemplos numéricos

**R1 · IGV como crédito fiscal.** subtotal = cantidad × costo unitario; IGV = subtotal × 0.18; total = subtotal + IGV. El IGV de las compras aprobadas se suma en el Resumen como crédito fiscal. El costo del inventario se calcula **sin IGV**.
> 10 u. × S/ 120.00 = **1,200.00** · IGV **216.00** · total **1,416.00**

**R2 · Aprobación.** Si el total es menor que S/ 5,000, la compra queda **Aprobada** al instante y aplica sus efectos. Si el total es S/ 5,000 o más, queda **Pendiente** y no cambia el stock, el costo promedio ni las cuentas por pagar. El Supervisor la **aprueba** (se aplican los efectos) o la **rechaza** con un motivo obligatorio (no cambia nada).
> 50 u. × 120.00 = 6,000.00 + IGV 1,080.00 = **7,080.00** ≥ 5,000 → Pendiente.
> El botón dice "Enviar a aprobación". Si el total es menor, dice "Registrar compra".

**R3 · Costo promedio ponderado** (se calcula al aprobar):
`nuevo = (stock × costoPromedio + cantidad × costoUnitario) / (stock + cantidad)`
> Stock 40 a 110.00, compra de 10 a 120.00 → (4,400 + 1,200) / 50 = **112.00** y stock **50**.
> Stock 40 a 110.00, compra de 50 a 120.00 → (4,400 + 6,000) / 90 = 115.555… = **115.56** y stock **90**.

**R4 · Contado o crédito.** Al contado, `pagada = true` y la compra no entra a Por pagar. A crédito a 30 días, `pagada = false` y `vence = fecha + 30 días`. Si está pendiente de pago y `vence < hoy`, se muestra la etiqueta **VENCIDA**.
> Compra a crédito del 03/11 → vence el 03/12. El 04/12 aparece en Vencidas.

**R5 · Pagar** (solo el Supervisor): `pagada = true`, sale de Pendientes y Vencidas y pasa a Pagadas. El total por pagar baja.
> Por pagar S/ 5,369.00; se paga una de S/ 2,183.00 → **S/ 3,186.00**.

**R6 · Visibilidad.** El Comprador solo ve las compras donde `comprador` es él. El filtro se hace con `#Predicate`.

**R7 · Registro y login.** El usuario es único sin distinguir mayúsculas (`"MTorres"` es igual a `"mtorres"`). La clave debe tener 6 caracteres como mínimo y coincidir con su confirmación. Al registrarse, la persona entra directo a la app. Si el login falla, aparece siempre el mismo mensaje: **"Usuario o clave incorrectos"**.

**R8 · Stock mínimo ★.** Si stock ≤ stockMinimo, el stock se pinta de rojo y aparece la insignia "Stock bajo". Si stock ≤ 2 × stockMinimo, se pinta de naranja. Si no, de verde.
> stockMinimo 5: 4 u. en rojo · 9 u. en naranja · 40 u. en verde.

## 5. Pantallas

Las pantallas B1 a B9 siguen la maqueta del enunciado. La pantalla B10 es el agregado.

| Pant. | Nombre | Rol | Elementos principales |
|---|---|---|---|
| B1 | Login | Todos | Logo "Compras Tecsup", usuario, clave oculta (`SecureField`), error genérico, Ingresar, enlace a Crear cuenta |
| B2 | Crear cuenta | Todos | Nombre, usuario con aviso "✓ Disponible" o "Ya existe", clave y confirmación, `Picker` segmentado de rol, Registrarme |
| B3 | Productos | Ambos | Botón + (Supervisor), `.searchable`, fila con iniciales, costo promedio y stock en color, tarjeta con el valor del inventario, `.onDelete` (Supervisor, bloqueado si el producto tiene compras). **Tocar una fila abre el Kardex ★** |
| B4 | Proveedores | Ambos | Botón + (Supervisor), fila con RUC, total comprado e insignia "N por pagar" o "Al día". Los valores se calculan desde `proveedor.compras` |
| B5 | Nueva compra | Comprador | Avatar con menú, `Picker` de proveedor y de producto, cantidad, costo unitario, segmentado Contado / Crédito 30 días, subtotal, IGV y total en vivo, aviso amarillo cuando el total llega a S/ 5,000, botón con texto dinámico |
| B6 | Mis compras | Comprador | Segmentado Todas / Pendientes / Rechazadas, insignia de estado, motivo del rechazo en rojo, solo sus compras |
| B7 | Aprobar | Supervisor | Tarjeta por cada compra pendiente con quién la solicitó, vista previa del stock y del costo promedio antes y después, Rechazar (alerta con motivo) y Aprobar |
| B8 | Por pagar | Supervisor | Segmentado Pendientes / Vencidas / Pagadas con `#Predicate`, búsqueda por proveedor, etiqueta VENCIDA, deslizar Pagar, total por pagar |
| B9 | Resumen | Supervisor | Tarjetas de inventario, crédito fiscal, por pagar y por aprobar (cantidad e importe), barras de total comprado por proveedor |
| B10 ★ | Kardex del producto | Ambos | Cabecera con stock actual, costo promedio y stock mínimo; gráfico de línea (Swift Charts) del costo promedio en el tiempo; lista de compras aprobadas con cantidad, costo, stock y costo promedio después de cada una |

Boceto de B10:
```
┌──────────────────────────────┐
│ ‹ Productos   Laptop Pro 14  │
│ Stock 50 u.  ·  Prom. S/112  │
│ Stock mínimo: 5      [Editar]│
│  costo prom.                 │
│  116 ┤            ●          │
│  112 ┤      ●                │
│  110 ┤ ●                     │
│      └─────────────────      │
│ 03/11 +10 a 120.00 → 50 u. S/112.00 │
│ 05/11 +50 a 120.00 → 100 u. S/116.00│
└──────────────────────────────┘
```

**Ícono:** cubo blanco con flecha amarilla sobre un fondo verde degradado. El nombre corto debajo del ícono es **"Compras"** (`CFBundleDisplayName`).

## 6. Casos de prueba

| N.º | Caso | Resultado esperado |
|---|---|---|
| 1 | Registrar a "mtorres" como Comprador e intentar registrar otra vez "MTorres" | El primero se crea y entra a la app. El repetido se rechaza con el aviso "Ya existe" |
| 2 | Login con la clave incorrecta | "Usuario o clave incorrectos" y no entra |
| 3 | Producto con stock 40 y costo promedio 110.00. Compra de 10 a 120.00 al crédito | Subtotal 1,200.00 · IGV 216.00 · total 1,416.00 · Aprobada · stock 50 · costo promedio 112.00 · vence a 30 días |
| 4 | La misma compra, pero al contado | Queda pagada y no aparece en Pendientes de pago |
| 5 | Compra de 50 a 120.00 (total 7,080.00) | Queda Pendiente de aprobación. El stock sigue en 40 y no suma a Por pagar |
| 6 | El Supervisor aprueba la compra del caso 5 | Stock 90 · costo promedio 115.56 · aparece en Por pagar |
| 7 | El Supervisor rechaza otra compra grande, primero sin motivo y luego con motivo | Sin motivo, el botón Rechazar está desactivado. Con motivo, queda Rechazada, el Comprador ve el motivo y el stock no cambia |
| 8 | Compra a crédito con vencimiento ya pasado; luego Pagar | Aparece en Vencidas con la etiqueta VENCIDA. Al pagar pasa a Pagadas y el total por pagar baja |
| 9 | Un Comprador abre Mis compras e intenta pagar | Solo ve sus compras y no tiene la opción Pagar |
| 10 | Supervisor: borrar un producto que tiene compras | Alerta "No se puede borrar…" y el producto sigue en la lista |
| 11 ★ | Kardex: producto en 40 a 110.00, se aprueban el caso 3 y después 50 u. a 120.00 | El Kardex muestra 2 movimientos: 50 u. a 112.00 y 100 u. a 116.00. El gráfico pasa por 110 → 112 → 116. Las compras pendientes o rechazadas no aparecen |
| 12 ★ | Producto con stock 4 y stock mínimo 5 | Insignia "Stock bajo" y stock en rojo en Productos y en el Kardex |

## 7. Ramas y plan de commits

**Ramas:**
- `main`: este expediente y la entrega final (merge al terminar).
- `manual`: lo que hago **sin ayuda**. Incluye el proyecto, los 4 modelos con sus relaciones y el diseño de las pantallas B1 a B10 según la maqueta, con datos de prueba y sin lógica de negocio.
- `ai-assisted`: parte de lo hecho en `manual` y le agrega con IA la lógica (sesión, reglas de negocio, `#Predicate`, permisos por rol, Resumen y Kardex). Cada consulta queda documentada en `PROMPTS.md`.

Haré un commit y un push **al terminar cada pantalla**:

| # | Rama | Mensaje del commit |
|---|---|---|
| 1 | main | `docs(semana12): expediente del caso Compras` |
| 2 | manual | `feat(semana12): crear proyecto Compras con SwiftUI y SwiftData` |
| 3 | manual | `feat(modelos): Usuario, Proveedor, Producto y Compra con relaciones .deny` |
| 4 | manual | `feat(B1-B2): diseño de login y crear cuenta` |
| 5 | manual | `feat(B3-B4): diseño de productos y proveedores` |
| 6 | manual | `feat(B5-B6): diseño de nueva compra y mis compras` |
| 7 | manual | `feat(B7-B10): diseño de aprobar, por pagar, resumen y kardex` |
| 8 | ai-assisted | `merge: traer pantallas y modelos de la rama manual` |
| 9 | ai-assisted | `feat(sesion): login, registro con usuario único y sesión` |
| 10 | ai-assisted | `feat(tabs): TabView por rol y menú de avatar con cerrar sesión` |
| 11 | ai-assisted | `feat(B3-B4): CRUD de productos y proveedores con borrado .deny` |
| 12 | ai-assisted | `feat(B5): registrar compra con IGV, contado/crédito y aprobación` |
| 13 | ai-assisted | `feat(B6-B7): mis compras y aprobar/rechazar con costo promedio` |
| 14 | ai-assisted | `feat(B8): por pagar con #Predicate, vencidas y pagar` |
| 15 | ai-assisted | `feat(B9): resumen del supervisor con barras por proveedor` |
| 16 | ai-assisted | `feat(B10): kardex con Swift Charts y stock mínimo` |
| 17 | ai-assisted | `feat: ícono de la app y nombre Compras` |
| 18 | ai-assisted | `docs(semana12): ficha técnica, README y PROMPTS.md` |
| 19 | main | `merge: entrega final semana 12` |

## 8. Función extra: Kardex del producto ★

**Problema:** el costo promedio cambia con cada compra aprobada, pero el enunciado solo muestra el valor actual. El supervisor no puede ver *por qué* un producto cuesta S/ 116 hoy, y nada le avisa cuando el stock está por agotarse.

**Solución:** al tocar un producto se abre su Kardex, que muestra:
- el historial de compras aprobadas (relación `producto.compras` filtrada por estado),
- el stock y el costo promedio que quedaron después de cada compra (`stockDespues` y `costoPromedioDespues`, que se guardan al aprobar),
- un gráfico de línea con Swift Charts,
- el stock mínimo, con alerta visual, que el supervisor puede editar.

**Por qué aporta:** reutiliza la relación Producto → Compra y la regla del costo promedio ponderado. El cálculo queda trazable y se puede verificar a mano (caso 11).
