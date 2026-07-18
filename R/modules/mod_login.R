# ============================================================
# asiste
# Módulo Login Docente
# ============================================================

# UI
mod_login_ui <- function(id){
  ns <- shiny::NS(id)
  shiny::tagList( # function that creates a flat, cohesive collection of UI elements. Unlike standard R lists, it bundles tags together with special classes that tell Shiny to process them properly during rendering.
    shiny::div( # HTML builder function in the Shiny framework that generates a <div> tag for web user interfaces. It lets you group, nest, and style UI elements while separating code from raw HTML

      class = "login-container",
      shiny::h2( # función de interfaz de usuario (UI) que genera un encabezado de nivel 2 (Tag HTML <h2>)
        "asiste"
      ),

      shiny::p( #  Shiny de R, la función p() se utiliza para crear un párrafo de texto HTML dentro de la interfaz de usuario (UI).
        "Sistema abierto de asistencia" ),

      shiny::actionButton( ns("google_login"), 
                          "Ingresar con Google", 
                          class = "btn-primary")
    )
  )
}

# SERVER
mod_login_server <- function( id, on_success = NULL ){

  shiny::moduleServer(
    id,
    function(input, output, session){

      observeEvent(
        input$google_login,
        {
          # Sprint inicial:
          # autenticación simulada
          if(!is.null(on_success)){
            on_success()

          }

        }

      )


    }

  )

}
