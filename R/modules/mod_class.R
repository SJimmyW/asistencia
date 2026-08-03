# ============================================================
# asiste
# Módulo Crear Nueva Clase
# ============================================================

mod_class_ui <- function(id){
  ns <- shiny::NS(id)
  
  shiny::tagList(
    bslib::card(
      bslib::card_header(shiny::h3("Crear Nueva Clase")),
      bslib::card_body(
        shiny::textInput(
          ns("class_id"),
          label = "ID de la clase (ej: MATH-101-01)",
          placeholder = "COURSE-ID"
        ),
        
        shiny::textInput(
          ns("class_name"),
          label = "Nombre de la clase",
          placeholder = "Ej: Cálculo I - Comisión 1"
        ),
        
        shiny::dateInput(
          ns("class_date"),
          label = "Fecha de la clase",
          value = Sys.Date()
        ),
        
        shiny::actionButton(
          ns("create_btn"),
          "Crear clase",
          class = "btn-primary"
        ),
        
        shiny::br(), shiny::br(),
        
        shiny::uiOutput(ns("status_msg"))
      )
    )
  )
}

mod_class_server <- function(id, on_created = NULL){
  
  shiny::moduleServer(
    id,
    function(input, output, session){
      ns <- session$ns
      
      class_state <- shiny::reactiveValues(message = NULL, type = NULL)
      
      output$status_msg <- shiny::renderUI({
        if (!is.null(class_state$message)) {
          class <- if (class_state$type == "error") "alert-danger" else "alert-success"
          shiny::div(
            class = paste("alert", class),
            class_state$message
          )
        }
      })
      
      shiny::observeEvent(
        input$create_btn,
        {
          class_id <- shiny::trimws(input$class_id)
          class_name <- shiny::trimws(input$class_name)
          class_date <- input$class_date
          
          if (class_id == "") {
            class_state$message <- "ID de clase es requerido."
            class_state$type <- "error"
            return()
          }
          
          if (class_name == "") {
            class_state$message <- "Nombre de clase es requerido."
            class_state$type <- "error"
            return()
          }
          
          tryCatch(
            {
              cfg <- get_google_config()
              nueva_clase <- data.frame(
                id_clase = class_id,
                nombre = class_name,
                fecha = class_date,
                stringsAsFactors = FALSE
              )
              
              sheet_append(cfg$sheets$clases, nueva_clase)
              
              class_state$message <- "Clase creada exitosamente. Redirigiendo..."
              class_state$type <- "success"
              
              if (!is.null(on_created)) {
                shiny::invalidateLater(1500)
                on_created(nueva_clase)
              }
            },
            error = function(e) {
              class_state$message <- paste("Error al crear clase:", e$message)
              class_state$type <- "error"
            }
          )
        }
      )
    }
  )
}
