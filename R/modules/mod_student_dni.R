# ============================================================
# asiste
# Módulo estudiante DNI
# ============================================================

mod_student_dni_ui <- function(id){
  
  ns <- shiny::NS(id) # namespace, clave para construir módulos. Evita que los ID de las entradas (inputs) y salidas (outputs) se dupliquen al prefijarlos de manera única,

  shiny::tagList( 
    shiny::h2(  "Registrar asistencia"),
    shiny::textInput( ns("dni"), "DNI" ),

    shiny::actionButton( ns("continue"),
                        "Continuar" ),
    shiny::uiOutput( ns("message") )
  )
}

mod_student_dni_server <- function(
  id, on_valid = NULL ){
  shiny::moduleServer(
    id,
    function(input, output, session){
      observeEvent( input$continue,  {
        valido <- validate_student_dni( input$dni  )

        if(valido){
          if(!is.null(on_valid)){ on_valid( input$dni)
                                } } else {

            output$message <- shiny::renderUI({
              shiny::div( 
                class="alert alert-danger",
                "DNI inválido. Use números sin puntos." )
              })
          }
        }
      )
    }
  )

}
