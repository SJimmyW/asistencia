# ============================================================
# asiste
#
# Copyright (C) 2026 SJWatson
# License: GPL-3.0
# Repository: https://github.com/SJimmyW/asistencia
# ============================================================

#--------------------------------------------------------------
# UI
#--------------------------------------------------------------

#' Pantalla final del Portal Estudiante
#' @param id Identificador del módulo.
#'
#' @export

mod_finish_ui <- function(id){

  ns <- shiny::NS(id)

  shiny::tagList( bslib::card(
    
    full_screen = FALSE,
    bslib::card_header( shiny::h3("Asistencia registrada") ),

      bslib::card_body( shiny::uiOutput( ns("summary") ),

        shiny::br(),

        shiny::actionButton( ns("close"),
                            "Finalizar",
                            class="btn-primary" )

      )
    )
  )
}

#--------------------------------------------------------------
# SERVER
#--------------------------------------------------------------

#' Server pantalla final
#'
#' @param id Identificador.
#' @param result Reactive con los resultados.
#' @param on_finish Función ejecutada al finalizar.
#'
#' @export

mod_finish_server <- function(
    id,
    result,
    on_finish=NULL
){

    shiny::moduleServer(
      id,
      function(input, output, session){

            output$summary <- shiny::renderUI({ req(result())
                                               r <- result()
                                               shiny::tagList( shiny::h4("¡Gracias por participar!"),
                                                              shiny::hr(),
                                                              shiny::p( strong("Asistencias registradas: "),
                                                                       r$total_attendance ),
                                                              
                                                              shiny::p( strong("Respuestas correctas: "),
                                                                       r$correct_answers ),
                                                              shiny::p( strong("Total de preguntas: "),
                                                                       r$total_questions ),
                                                              shiny::p( strong("Puntaje obtenido: "),
                                                                       paste0( round(r$score_percent,2), "%" ) )
                                                             )
            })

            observeEvent( input$close, {

                    if(is.function(on_finish))

                        on_finish()
                }
            )
        }
    )
}
