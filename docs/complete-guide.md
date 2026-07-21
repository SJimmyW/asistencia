# Guía completa de asiste

## ¿Qué es asiste?

asiste es un sistema de código abierto para:
- Registrar asistencia con QR
- Realizar evaluación formativa automática
- Almacenar datos en Google Sheets
- Mostrar dashboards de docentes

## Flujo de uso típico

### Para docentes

1. **Login**: Ingresar con email registrado en la hoja Docentes
2. **Home**: Ver estadísticas del curso
3. **Nueva Clase**: Crear una nueva sesión de clase
4. **QR**: Mostrar código QR a estudiantes

### Para estudiantes

1. **Escanear QR** o ingresar URL de la sesión
2. **Ingresar DNI**: Verificación contra hoja de Estudiantes
3. **Responder preguntas**: Formulario de evaluación formativa
4. **Ver resultado**: Resumen con calificación

## Estructura de datos en Google Sheets

### Hoja: Docentes
Columnas: `email`, `nombre`, `rol`, `comision`, `activo`

### Hoja: Estudiantes
Columnas: `dni`, `nombre`, `email`

### Hoja: Clases
Columnas: `id_clase`, `nombre`, `fecha`

### Hoja: Preguntas
Columnas: `id_pregunta`, `id_clase`, `pregunta`, `opciones` (separadas por |), `correcta`, `puntos`

Ejemplo de `opciones`: `Opción A|Opción B|Opción C|Opción D`

### Hoja: Asistencia
Columnas: `id_clase`, `dni`, `fecha_hora`, `puntos`

### Hoja: Respuestas
Columnas: `id_clase`, `dni`, `id_pregunta`, `respuesta`, `correcta`, `puntos`

## Cómo corregir preguntas automáticamente

La columna `correcta` en la hoja Preguntas debe contener la opción correcta.
El sistema compara automáticamente y cuenta aciertos.

## Configuración avanzada

Editar `config.yml` para:
- Cambiar nombres de hojas
- Configurar zona horaria
- Ajustar duración de sesiones QR
- Personalizar tema de UI
