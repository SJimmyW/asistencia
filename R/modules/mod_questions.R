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

#' Portal Estudiante - Preguntas
#' @param id Identificador del módulo.
#'
#' @export

mod_questions_ui <- function(id){

  ns <- shiny::NS(id)
  shiny::tagList( bslib::card(
    bslib::card_header( shiny::h3("Preguntas de la clase") ),

      bslib::card_body(  shiny::uiOutput( ns("questions_ui") ),

        shiny::br(),

        shiny::actionButton( ns("finish"), 
                            "Finalizar", class = "btn-success"  )
      )
    )
  )
}

#--------------------------------------------------------------
# SERVER
#--------------------------------------------------------------

#' Server preguntas
#'
#' @param id Identificador.
#' @param id_clase Clase actual.
#' @param on_success Función llamada al finalizar.
#'
#' @export

mod_questions_server <- function(
    id,
    id_clase,
    on_success=NULL
){

    shiny::moduleServer( id,
                        
                        function(input, output, session){
                          ns <- session$ns
                          preguntas <- shiny::reactive({ sheet_get_questions(id_clase) })

            output$questions_ui <- shiny::renderUI({
              
              req(preguntas())
              p <- preguntas()

                if(nrow(p)==0){ return(

                        shiny::div( shiny::h4( "Esta clase no posee preguntas."   )

                        )

                    )

                }

                controles <- vector( "list", nrow(p) )

                for(i in seq_len(nrow(p))){

                    opciones <- unlist( strsplit( p$opciones[i], "\\|" ) )

                    controles[[i]] <- shiny::radioButtons( inputId = ns( paste0("q_",i) ),

                            label = p$pregunta[i],
                            choices = opciones,
                            selected = character(0)
                        )
                }

                shiny::tagList(controles)

            })

            observeEvent( input$finish, {

                    p <- preguntas()

                    if(nrow(p)==0){
                      if(is.function(on_success)){
                            on_success(
                                data.frame()
                            )
                        }
                        return()
                    }

                    respuestas <- data.frame(  pregunta=p$pregunta,
                                             respuesta = NA_character_,
                                             stringsAsFactors=FALSE )

                    for(i in seq_len(nrow(p))){

                        respuestas$respuesta[i] <- input[[paste0("q_",i)]]

                    }

                    if(is.function(on_success)){  on_success( respuestas )

                    }

                }

            )

        }

    )

}
