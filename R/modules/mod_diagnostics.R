# ============================================================
# asiste
# Módulo Diagnóstico
# ============================================================

mod_diagnostics_ui <- function(id){
  ns <- shiny::NS(id)
  shiny::tagList(
    shiny::h2("Diagnóstico del Google Sheet"),
    shiny::p("Muestra el resultado de validate_sheets() en forma legible."),
    shiny::actionButton(ns("refresh"), "Refrescar"),
    shiny::verbatimTextOutput(ns("diag_text"))
  )
}

mod_diagnostics_server <- function(id){
  shiny::moduleServer(id, function(input, output, session){
    cfg <- load_config()
    diag_res <- shiny::reactiveVal(NULL)

    shiny::observeEvent(input$refresh, {
      res <- tryCatch(
        validate_sheets(cfg, stop_on_error = FALSE),
        error = function(e) list(ok = FALSE, error = e$message)
      )
      diag_res(res)
    }, ignoreNULL = FALSE)

    output$diag_text <- shiny::renderPrint({
      res <- diag_res()
      if(is.null(res)) return("Sin resultados aún. Pulse 'Refrescar'.")
      print(res)
    })
  })
}
