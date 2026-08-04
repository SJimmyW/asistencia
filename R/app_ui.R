# ============================================================
# asiste
# Interfaz principal
# ============================================================

#' Aplicación UI
#' Construye la interfaz principal de la aplicación.
#' @export
#'

app_ui <- function(){
  shiny::fluidPage(
    theme = bslib::bs_theme( version = 5, bootswatch = "flatly" ),

    shiny::tags$head( shiny::tags$title( APP_NAME )  ),

    shiny::div( class = "container-fluid",
               shiny::uiOutput( "page" )

    )
  )
}
