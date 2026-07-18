figma/screens/STD_DNI.md
````markdown
# STD_DNI

## Objetivo

Registrar la asistencia.

---

## Layout

Logo
Título
Campo DNI
Botón Continuar

---

## Validaciones

Solo números
8 dígitos
Sin puntos

Ejemplo válido 34567890

---

## Acción
Registrar asistencia
↓
Si existen preguntas
↓
STD_Questions
Si no
↓
STD_End

---

## Módulo

mod_student_dni.R
