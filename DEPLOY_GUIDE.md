# asiste Deployment Guide

## 🚀 Deploy en Replit

### 1. Crear proyecto en Replit
- Ve a https://replit.com
- Click **"Create"** → **"Import from GitHub"**
- Pega: `https://github.com/SJimmyW/asistencia`
- Selecciona **"R"** como lenguaje

### 2. Configurar variables de entorno
- Click **"Secrets"** (candado en la izquierda)
- Agrega variable `GOOGLE_SHEETS_ID` con tu Sheet ID
- Agrega variable `GOOGLE_API_KEY` si necesitas (opcional)

### 3. Ejecutar
- Click **"Run"**
- La app se abrirá automáticamente en la ventana "Webview"
- URL pública: https://tu-username.replit.dev

### Tips:
- Replit instala paquetes automáticamente desde `replit.nix`
- El archivo `main.R` se ejecuta al iniciar
- Puedes revisar logs en la consola

---

## 🐳 Deploy en Render

### 1. Crear servicio en Render
- Ve a https://dashboard.render.com/
- Click **"New +"** → **"Web Service"**
- Selecciona tu repo `SJimmyW/asistencia`
- Conecta tu cuenta GitHub si es necesario

### 2. Configurar servicio
- **Name:** asiste
- **Runtime:** Docker
- **Port:** 3838
- **Region:** Cualquiera (ej: Ohio, Singapore)
- **Plan:** Free

### 3. Agregar variables de entorno
- Click **"Environment"**
- Agrega:
  - **Key:** `GOOGLE_SHEETS_ID` → **Value:** Tu Sheet ID
  - **Key:** `TZ` → **Value:** `America/Argentina/Cordoba`

### 4. Deploy
- Click **"Create Web Service"**
- Render automáticamente:
  - Clona el repo
  - Construye el Docker image
  - Inicia el contenedor
  - Te da una URL pública: `https://asiste-xxxxx.onrender.com`

### 5. Monitoreo
- Los logs aparecen en **"Logs"**
- Puedes ver métricas en **"Metrics"**
- Para actualizar: git push a main (auto-redeploy)

---

## 📋 Checklist de Deployment

### Antes de deployar:
- [ ] Google Sheets creado con todas las hojas
- [ ] Google OAuth habilitado
- [ ] Sheet ID copiado
- [ ] Repo en GitHub actualizado

### Después de deployar:
- [ ] App carga sin errores
- [ ] Login funciona
- [ ] Google Sheets se conecta
- [ ] Puedes crear una clase
- [ ] Puedes ingresar un DNI

---

## 🔧 Troubleshooting

### En Replit:
**Error: "Package not found"**
- Click **"Tools"** → **"Package Manager"**
- Busca el paquete y clickea **"Install"**

**Error: "Cannot connect to Google Sheets"**
- Verifica que `GOOGLE_SHEETS_ID` está correcto en Secrets
- Verifica que el Sheet es público o tu cuenta tiene acceso

### En Render:
**Build failed**
- Revisa **"Logs"** para ver el error
- Asegúrate de que el `Dockerfile` está en la raíz del repo
- Intenta hacer un nuevo deploy (botón "Manual Deploy")

**App no carga**
- Verifica que puerto 3838 está correcto
- Revisa los logs de la aplicación
- Intenta reiniciar el servicio

**Timeout al conectar Google Sheets**
- Aumenta timeout en `R/google_config.R`
- Verifica tu conexión a internet
- Prueba con una hoja de ejemplo primero

---

## 📊 Comparación

| Feature | Replit | Render |
|---------|--------|--------|
| Horas/mes | Ilimitadas | Ilimitadas (free tier) |
| Mejor para | Desarrollo/testing | Producción |
| Uptime | ~95% | ~99.5% |
| Customización | Media | Alta |
| Costo | Gratis | Gratis (plan free) |
| Auto-redeploy | No | Sí (con git push) |
