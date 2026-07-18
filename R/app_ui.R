# ============================================================
# asiste
# Interfaz principal
# ============================================================

#' Aplicación UI, construye la interfaz principal.
#'
#' @export

app_ui <- function(){

  shiny::fluidPage( theme = bslib::bs_theme(  version = 5,
                                            bootswatch = "flatly" ),

    shiny::div( class = "container",
               shiny::h1( APP_NAME ),

      shiny::p( "Sistema abierto de asistencia" ),

      shiny::hr(),

      shiny::uiOutput( "main_content" ) )
  )
}
