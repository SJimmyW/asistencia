# Guía Completa de asiste

## ¿Qué es asiste?

asiste es un sistema de código abierto para:
- Registrar asistencia con QR
- Realizar evaluación formativa automática
- Almacenar datos en Google Sheets
- Mostrar dashboards de docentes

## Flujo de uso

### Para docentes

1. **Login**: Ingresar con email registrado en la hoja Docentes
2. **Home**: Ver estadísticas del curso
3. **Nueva Clase**: Crear una nueva sesión
4. **QR**: Mostrar código QR a estudiantes

### Para estudiantes

1. **Escanear QR** o ingresar URL
2. **Ingresar DNI**: Verificación contra hoja Estudiantes
3. **Responder preguntas**: Formulario de evaluación
4. **Ver resultado**: Resumen con calificación

## Estructura de datos en Google Sheets

### Hoja: Docentes
- `email` - Correo del docente
- `nombre` - Nombre completo
- `rol` - Rol/posición
- `comision` - Comisión asignada
- `activo` - 1/0 para activo/inactivo

### Hoja: Estudiantes
- `dni` - Número de DNI
- `nombre` - Nombre completo
- `email` - Email del estudiante

### Hoja: Clases
- `id_clase` - ID único de la clase
- `nombre` - Nombre de la clase
- `fecha` - Fecha de la clase

### Hoja: Preguntas
- `id_pregunta` - ID único
- `id_clase` - Clase a la que pertenece
- `pregunta` - Texto de la pregunta
- `opciones` - Opciones separadas por |
- `correcta` - Opción correcta
- `puntos` - Puntos asignados

Ejemplo de `opciones`: `Opción A|Opción B|Opción C|Opción D`

### Hoja: Asistencia
- `id_clase` - ID de la clase
- `dni` - DNI del estudiante
- `fecha_hora` - Cuándo se registró
- `puntos` - Puntos obtenidos

### Hoja: Respuestas
- `id_clase` - ID de la clase
- `dni` - DNI del estudiante
- `id_pregunta` - ID de la pregunta
- `respuesta` - Respuesta dada
- `correcta` - 1/0 si es correcta
- `puntos` - Puntos obtenidos

## Corrección automática

La columna `correcta` en Preguntas debe contener exactamente la opción correcta.
El sistema compara automáticamente y califica.

## Configuración avanzada

Editar `config.yml` para:
- Cambiar nombres de hojas
- Configurar zona horaria
- Ajustar duración de sesiones
- Personalizar tema de UI
