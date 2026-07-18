# ============================================================
# asiste
# Componente Header
# ============================================================

app_header <- function(){

  shiny::div( class = "app-header",
             bslib::card( bslib::card_body(
               shiny::fluidRow(
                 shiny::column(  width = 8,
                               shiny::h3( APP_NAME ) ),
                 shiny::column( width = 4,
                               shiny::div( style = "text-align:right",
                                          shiny::textOutput( "user_name") ) ) ) ) 
                        )
             )
}
