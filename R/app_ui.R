# ============================================================
# asiste
# Interfaz principal
# ============================================================

#' Aplicación UI
#' Construye la interfaz principal de la aplicación.
#' @export
#'

app_ui <- function(){
  shiny::fluidPage(
    theme = bslib::bs_theme( version = 5, bootswatch = "flatly" ),

    shiny::tags$head( shiny::tags$title( APP_NAME )  ),

    shiny::div( class = "container-fluid",
               shiny::uiOutput( "page" )

    )
  )
}

output$main_content <- renderUI({

    switch( state$page,
           login = mod_login_ui("login"),
           home = mod_home_ui("home"),
           class = mod_class_ui("class"),
           qr = mod_qr_ui("qr"),
           student = mod_student_dni_ui("student"),
           questions = mod_questions_ui("questions"),
           finish = mod_finish_ui("finish")
    )

})
