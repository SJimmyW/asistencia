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

  options(

    asiste.config = cfg,

    shiny.maxRequestSize = 50 * 1024^2

  )

  shiny::shinyApp(

    ui = app_ui(),

    server = app_server,

    options = list(...)

  )

}
