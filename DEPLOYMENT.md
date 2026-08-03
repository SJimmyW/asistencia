# asiste - Deployment Guide

## Opción 1: Shiny.io (Recomendado - Más fácil)

### Prerequisitos
- Cuenta en [shinyapps.io](https://www.shinyapps.io/)
- R con rsconnect instalado

### Pasos

1. **Instalar rsconnect:**
```r
install.packages("rsconnect")
```

2. **Conectar tu cuenta Shiny.io en RStudio:**
   - Ir a: Tools > Global Options > Publishing
   - Click "Connect..." y seguir las instrucciones

3. **Desplegar la app:**
```r
rsconnect::deployApp(
  appDir = getwd(),
  appName = "asiste",
  launch.browser = TRUE
)
```

4. **La app estará en:** `https://YOUR_USERNAME.shinyapps.io/asiste/`

### Actualizar la app después de cambios:
```r
rsconnect::deployApp()
```

---

## Opción 2: Docker (Para servidor propio)

### Prerequisitos
- Docker y Docker Compose instalados

### Pasos

1. **Crear archivo `.env` con tu Google Sheets ID:**
```
GOOGLE_SHEETS_ID=tu_google_sheets_id_aqui
```

2. **Construir y ejecutar:**
```bash
docker-compose up -d
```

3. **La app estará en:** `http://localhost:3838`

4. **Ver logs:**
```bash
docker-compose logs -f asiste
```

5. **Detener la app:**
```bash
docker-compose down
```

---

## Opción 3: Servidor Linux (DigitalOcean, AWS, etc)

### Pasos rápidos:

1. **SSH a tu servidor**
2. **Instalar R y dependencias:**
```bash
sudo apt-get update
sudo apt-get install -y r-base r-base-dev
```

3. **Instalar Shiny Server:**
```bash
sudo apt-get install -y gdebi-core
wget https://download3.rstudio.org/ubuntu-14.04/x86_64/shiny-server-1.5.20.1002-amd64.deb
sudo gdebi shiny-server-1.5.20.1002-amd64.deb
```

4. **Clonar repo:**
```bash
cd /srv/shiny-server
sudo git clone https://github.com/SJimmyW/asistencia.git
sudo chown -R shiny:shiny asistencia
```

5. **Editar configuración de Shiny:**
```bash
sudo nano /etc/shiny-server/shiny-server.conf
```

Agregar:
```
location /asiste {
  app_dir /srv/shiny-server/asistencia;
  log_dir /var/log/shiny-server;
}
```

6. **Reiniciar Shiny Server:**
```bash
sudo systemctl restart shiny-server
```

7. **La app estará en:** `http://tu-servidor-ip:3838/asiste/`

---

## Consideraciones Importantes

### Credenciales de Google Sheets
- NO commits `config.yml` con credenciales reales
- Usar variables de entorno en producción
- En Shiny.io: Secrets en Settings

### Seguridad
- Usar HTTPS (Shiny.io lo hace automáticamente)
- Implementar rate limiting
- Validar todos los inputs
- Mantener dependencies actualizadas

### Monitoreo
- Revisar logs regularmente
- Configurar alertas
- Backup automático de datos

---

## Troubleshooting

### "Package not found"
```r
# En la consola R del servidor
install.packages("nombre_del_paquete")
```

### "Cannot connect to Google Sheets"
- Verificar `config.yml`
- Verificar que Google Sheets es accesible
- Ejecutar `validate_sheets()` localmente

### "Port already in use"
```bash
sudo lsof -i :3838
sudo kill -9 PID
```
