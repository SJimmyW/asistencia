# ============================================================
# asiste
# Componentes gráficos
# ============================================================

chart_bar <- function(
    output_id,
    title = ""
){
  shiny::plotOutput( output_id,
                    height = "300px")

}
