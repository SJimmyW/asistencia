# ============================================================
# asiste
# Dashboard de una clase
# ============================================================

mod_dashboard_class_ui <- function(id){
  
  ns <- shiny::NS(id)
  shiny::tagList( shiny::h2( "Dashboard clase" ),

    bslib::layout_columns( bslib::card( "Presentes",
                                       shiny::textOutput( ns("presentes") ) ),
                          bslib::card( "Ausentes",
                                      shiny::textOutput( ns("ausentes")  )  ),
                          bslib::card( "Promedio respuestas",
                                      shiny::textOutput( ns("promedio") ) ) 
                         ),

    shiny::plotOutput( ns("preguntas") ),
                 shiny::tableOutput( ns("tabla") ) 
                )
}

mod_dashboard_class_server <- function(
  id ){

  shiny::moduleServer(
    id,
    function(input, output, session){
      
      output$presentes <- shiny::renderText( 0 )
      output$ausentes <- shiny::renderText( 0 )
      output$promedio <- shiny::renderText(  "0%" )
      output$preguntas <- shiny::renderPlot({
        barplot( numeric(0),
                main = "Respuestas por pregunta" ) })
      output$tabla <- shiny::renderTable({
        data.frame( DNI = character(),
                   Nombre = character(),
                   Asistencia = character(),
                   Puntos = numeric() )
        })
    }
  )
}
