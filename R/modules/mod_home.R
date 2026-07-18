# ============================================================
# asiste
# Módulo Inicio Docente
# ============================================================

mod_home_ui <- function(id){
  ns <- shiny::NS(id)

  shiny::tagList(

    shiny::h2( "Inicio" ),

    shiny::fluidRow(

      shiny::column( width = 3,
                    bslib::card(
                      bslib::card_header( "Clases" ),
                      0 ) ),

      shiny::column( width = 3,
                    bslib::card(
                      bslib::card_header( "Asistencia promedio" ), "0 %" ) ),

      shiny::column( width = 3,
                    bslib::card(
                      bslib::card_header( "Estudiantes"), 0 ) ),

      shiny::column( width = 3,
                    bslib::card(
                      bslib::card_header( "Respuestas" ), "0 %" ) ) ),

    shiny::hr(),
    
    shiny::actionButton( ns("new_class"),
                        "Nueva clase" ) )
}

mod_home_server <- function( id ){

  shiny::moduleServer(
    id,
    
    function(input, output, session){

      observeEvent( input$new_class, {
          shiny::showNotification( "Nueva clase",
                                  type = "message"
                                 )
        }
      )
    }
  )

}
