# ============================================================
# asiste
# Punto de entrada de la aplicación
# ============================================================

# Punto de entrada de la aplicación

# Cargar todos los archivos R automáticamente
source_files <- list.files(
  path = "R",
  pattern = "\\.R$",
  recursive = TRUE,
  full.names = TRUE )

purrr::walk(
  source_files,
  source
)
# app.R
# Ejecutar aplicación

shiny::shinyApp(
  ui = app_ui(),
  server = app_server )

# options(  shiny.autoreload = TRUE ) ;library(asiste) ;run_app()
