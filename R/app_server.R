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
                     pagina( "home" )
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
                         on_valid = function(dni) { 
                           pagina( "student_questions"  )
                         }
  )
}
