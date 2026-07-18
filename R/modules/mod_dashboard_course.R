# ============================================================
# asisteUNRC
# Dashboard general asignatura
# ============================================================

mod_dashboard_course_ui <- function(id){

  ns <- shiny::NS(id)

  shiny::tagList(

    shiny::h2( "Dashboard asignatura" ),

    bslib::layout_columns(
      bslib::card( "Clases realizadas",
                  shiny::textOutput( ns("n_clases") )  ),

      bslib::card( "Asistencia promedio",
                  shiny::textOutput( ns("asistencia") ) ),

      bslib::card( "Estudiantes activos",
                  shiny::textOutput( ns("estudiantes") ) ),


      bslib::card( "Respuestas correctas",
                  shiny::textOutput( ns("puntos") ) )
    ),

    shiny::plotOutput( ns("asistencia_plot") ),
    shiny::plotOutput( ns("puntos_plot")  )

  )
}


mod_dashboard_course_server <- function(
    id ){

  shiny::moduleServer(
    id,
    function(input, output, session){

      output$n_clases <- shiny::renderText( 0 )
      output$asistencia <- shiny::renderText( "0%")
      output$estudiantes <- shiny::renderText( 0  )

      output$puntos <- shiny::renderText(
        "0%" )

      output$asistencia_plot <- shiny::renderPlot({
        plot( numeric(0),  
             main ="Evolución asistencia" ) })

      output$puntos_plot <- shiny::renderPlot({
        plot( numeric(0),
             main = "Evolución respuestas" )
      })
    }
  )

}
