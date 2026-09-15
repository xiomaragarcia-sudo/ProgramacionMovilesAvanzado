# Actividad Propuesta 02 - Sistema de Gestión de Clientes Bancarios

## 📌 Descripción del Caso
Una entidad bancaria requiere una plataforma interactiva para la administración y control de sus clientes. El sistema debe permitir gestionar tanto a personas naturales como a entidades jurídicas, asegurando el registro de datos generales de cuentas bancarias y los atributos particulares correspondientes a cada tipo de cliente.

---

## ⚙️ Requerimientos Funcionales (RF)

* **RF-01: Gestión de Tipos de Clientes**
  * El sistema debe permitir diferenciar y almacenar la información de dos categorías de clientes: **Cliente Natural** (personas individuales) y **Cliente Jurídico** (empresas e instituciones).

* **RF-02: Registro de Información Base de Cuenta**
  * El sistema debe capturar y asociar a todo cliente los datos esenciales de su cuenta bancaria:
    * Código único de cliente.
    * Dirección domiciliaria o fiscal.
    * Fecha de registro en el sistema.
    * Número de cuenta bancaria asignado.
    * Monto mínimo de apertura exigido.

* **RF-03: Captura de Datos Específicos por Tipo de Cliente**
  * **Para Cliente Natural:** El sistema debe registrar obligatoriamente el **Nombre Completo** y el **DNI**.
  * **Para Cliente Jurídico:** El sistema debe registrar obligatoriamente la **Razón Social**, el **RUC** y el **Representante Legal**.

* **RF-04: Inicialización de Datos Predeterminados**
  * El sistema debe iniciar de manera predeterminada con los clientes registrados inicialmente en la base del banco (*Juan Pérez* como Cliente Natural y *Soluciones SAC* como Cliente Jurídico) para garantizar la disponibilidad inmediata de información.

* **RF-05: Menú Interactivo de Operaciones**
  * El sistema debe proporcionar una interfaz de consola interactiva con las siguientes opciones independientes:
    1. Registrar un nuevo Cliente Natural.
    2. Registrar un nuevo Cliente Jurídico.
    3. Listar y visualizar las fichas completas de todos los clientes registrados.
    4. Salir de la aplicación.

* **RF-06: Formato y Presentación de Fichas de Clientes**
  * El sistema debe presentar la Ficha General de Clientes formateada con identificadores visuales (iconografía/emojis) diferenciando claramente los campos de las personas naturales de las empresas.