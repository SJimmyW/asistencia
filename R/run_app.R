#' Run asiste
#' Launches the asiste Shiny application.
#'
#' This function:
#'
#' * Reads configuration from config.yml
#' * Initializes global options
#' * Builds the UI
#' * Starts the Shiny application
#'
#' Note: Google Sheets validation is deferred to when sheets are actually accessed,
#' allowing the app to start even without Google credentials in development/testing.
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

  # Note: Google Sheets validation is deferred to actual usage
  # This allows the app to start without Google credentials in dev/test environments

  shiny::shinyApp(

    ui = app_ui(),

    server = app_server,

    options = list(...)

  )

}
