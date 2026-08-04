# ============================================================
# asiste - App Init Script
# Punto de entrada para Render/Docker
# ============================================================

# Cargar librerías primero
library(shiny)
library(bslib)
library(googlesheets4)
library(purrr)
library(config)
library(digest)

# Cargar todos los archivos R (excepto los que no sean funciones puras)
source_files <- list.files(
  path = "R",
  pattern = "\\.R$",
  recursive = TRUE,
  full.names = TRUE,
  ignore.case = TRUE
)

# Excluir app_ui.R y app_server.R por ahora
source_files <- source_files[!grepl("app_(ui|server|vieja|init)", source_files)]

# Source todos los archivos de funciones/módulos primero
invisible(lapply(source_files, source))

# Ahora source app_server.R y app_ui.R
app_ui_file <- list.files(path = "R", pattern = "^app_ui\\.R$", recursive = TRUE, full.names = TRUE)
app_server_file <- list.files(path = "R", pattern = "^app_server\\.R$", recursive = TRUE, full.names = TRUE)

if (length(app_ui_file) > 0) source(app_ui_file[1])
if (length(app_server_file) > 0) source(app_server_file[1])

# Ejecutar la aplicación
run_app(host = "0.0.0.0", port = 3838)
