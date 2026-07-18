# ============================================================
# asiste
# Tarjetas estadísticas
# ============================================================

card_statistic <- function(
    title,
    value ){
  
  bslib::card(
    bslib::card_header( title ),
    bslib::card_body( shiny::h2( value ) ) )
}
