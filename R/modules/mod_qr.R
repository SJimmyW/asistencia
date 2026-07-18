# ============================================================
# asiste
# Módulo generación QR
# ============================================================

mod_qr_ui <- function(id){

  ns <- shiny::NS(id)
  shiny::tagList(
    shiny::h2( "Código QR" ),
    shiny::uiOutput( ns("qr") ),
    shiny::textOutput( ns("info")  ),

   shiny::downloadButton(
     ns("download"),
      "Descargar QR" )
  )
}

mod_qr_server <- function(
    id,
    clase ){

  shiny::moduleServer(
    id,
    function(input, output, session){

      output$qr <- shiny::renderUI({
        req(clase())
        shiny::tags$img( src = "qr_placeholder.png",
                        width = "300px" )  })

      output$info <- shiny::renderText({
        req(clase())
        paste( "Clase:", clase()$clase, "|", "Fecha:", clase()$fecha )

        })

    }
  )
}
