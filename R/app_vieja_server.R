# ============================================================
# asiste
# Servidor principal
# ============================================================

#' Aplicación Server
#' Control principal de Shiny.
#'
#' @param input input Shiny
#' @param output output Shiny
#' @param session sesión Shiny
#'@export
#'

app_server <- function(
    input,
    output,
    session
){

# ==========================================================
# Estado de navegación
# ==========================================================
  pagina <- shiny::reactiveVal( "login" )

# ==========================================================
# Render pantalla actual
# ==========================================================

  output$page <- shiny::renderUI({
    switch( pagina(), 
           "login",
           mod_login_ui( "login" ),

        "home",
        mod_home_ui( "home" ),

        "student_dni",
           mod_student_dni_ui( "student_dni" ),

        shiny::h3( "Página no encontrada" )
      )
    })

# ==========================================================
# LOGIN
# ==========================================================

  mod_login_server( "login",
                   on_success = function(){
                    state$page <- "home" # pagina( "home" )
    }
  )

# ==========================================================
# HOME DOCENTE
# ==========================================================

  mod_home_server( "home" )

# ==========================================================
# ESTUDIANTE
# ==========================================================

  mod_student_dni_server( "student_dni",
                         on_success = function(dni) { 
                           pagina( "student_questions"  )
                         }
  )
}

#--------------------------------------------------------------
# Estado global de la aplicación
#--------------------------------------------------------------

state <- shiny::reactiveValues( page = "login",
                               teacher = NULL, 
                               class = NULL,
                               qr = NULL, 
                               token = NULL, 
                               student = NULL, 
                               attendance = NULL,  
                               answers = NULL, 
                               result = NULL )

