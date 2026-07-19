#' Run asiste
#' Launches the asiste Shiny application.
#'
#' This function:
#'
#' * Reads configuration from config.yml
#' * Initializes global options
#' * Verifies Google Sheets configuration
#' * Builds the UI
#' * Starts the Shiny application
#'
#' @param ... Arguments passed to shinyApp().
#'
#' @return Invisibly returns the running Shiny application.
#'
#' @export

run_app <- function(...) {

  cfg <- load_config()

  # Guardar configuración en opciones globales
  options(

    asiste.config = cfg,

    shiny.maxRequestSize = 50 * 1024^2

  )

  # Validar Google Sheets antes de iniciar la app.
  # Esto comprobará accesibilidad, existencia de hojas y columnas mínimas.
  # Si la validación falla, por defecto detendrá la ejecución con un error
  # claro.
  validate_sheets(cfg = cfg, stop_on_error = TRUE)

  shiny::shinyApp(

    ui = app_ui(),

    server = app_server,

    options = list(...)

  )

}
