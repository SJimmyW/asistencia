# ============================================================
# asiste
# Sidebar navegación
# ============================================================

app_sidebar <- function(){
  shiny::div( class = "sidebar",
             shiny::actionLink(
               "nav_home", "Inicio" ),
             shiny::br(),
             shiny::actionLink( "nav_classes",
                               "Clases" ),
             shiny::br(),
             shiny::actionLink( "nav_dashboard",  "Dashboard"  ),
             shiny::br(), shiny::actionLink( "nav_settings", "Configuración" ) )

}
