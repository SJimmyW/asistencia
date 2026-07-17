figma/screens/DOC_NewClass.md
````markdown
# DOC_NewClass

## Objetivo
Crear una nueva clase y generar el QR de asistencia.
Toda la información proviene del Google Sheets.
No se almacena información local.

---

## Frame

Desktop

1440 × 1024

---

# Layout
┌──────────────────────────────────────────────────────────────┐
│ Header │
├──────────────┬───────────────────────────────────────────────┤
│ Sidebar │ │
│ │ Nueva clase │
│ │ │
│ │ Formulario │
│ │ │
│ │ Vista previa │
│ │ │
└──────────────┴───────────────────────────────────────────────┘

---

# Formulario

## Asignatura

Dropdown

Origen

Hoja **Asignaturas**

---

## Clase

TextField

Ejemplos:
## Fecha
DatePicker
## Hora inicio
TimePicker
## Hora fin
TimePicker
## Preguntas

Si = Sí
La aplicación buscará automáticamente las preguntas correspondientes a esa clase.
---

## Botón principal

---
## Vista previa Antes de crear el QR mostrar

Switch

