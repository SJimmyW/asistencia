# ============================================================
# asiste
# Módulo creación de clases
# ============================================================

mod_class_ui <- function(id){
  ns <- shiny::NS(id)

  shiny::tagList(
    shiny::h2( "Nueva clase" ),

    shiny::selectInput( ns("asignatura"),
                       "Asignatura", choices = NULL ),
    shiny::textInput( ns("clase"),
                     "Clase" ),

    shiny::dateInput( ns("fecha"),
                     "Fecha" ),

    shiny::timeInput(
      ns("hora_inicio"),
      "Hora inicio" ),

    shiny::timeInput(
      ns("hora_fin"),
      "Hora fin" ),

    shiny::checkboxInput( ns("preguntas"),
                         "Activar preguntas", value = FALSE ),

    shiny::actionButton(
      ns("crear"),
      "Generar QR" )
  )
}


mod_class_server <- function(
    id,
    on_created = NULL ){

  shiny::moduleServer(
    id,
    function(input, output, session){
      observeEvent( input$crear, {
          req( input$clase, input$fecha )
          nueva_clase <- data.frame(
            asignatura = input$asignatura,
            clase = input$clase,
            fecha = input$fecha,
            hora_inicio = input$hora_inicio,
            hora_fin = input$hora_fin,
            preguntas = input$preguntas
          )

          if(!is.null(on_created)){
            on_created( nueva_clase )
          }

        }

      )
    }
  )
}
