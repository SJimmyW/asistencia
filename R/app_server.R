# ============================================================
# asiste
# Servidor principal
# ============================================================

#' Aplicación Server
#' Control principal de Shiny.
#'
#' @param input input Shiny
#' @param output output Shiny
#' @param session sesión Shiny
#'
#' @export

app_server <- function( input,
                       output,
                       session ){
  output$main_content <- shiny::renderUI({
    shiny::tagList(
      shiny::h3( "Bienvenido a asisteUNRC" ),

      shiny::p( "Aplicación inicial funcionando." )

    )
  })

}
