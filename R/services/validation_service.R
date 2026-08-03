# ============================================================
# asiste
# Servicio de validación de datos
# ============================================================

#' Validar estructura de respuestas
#' @param respuestas data.frame con columnas pregunta, respuesta
#' @return logical
#' @export
validate_answers <- function(respuestas) {
  if (!is.data.frame(respuestas)) return(FALSE)
  if (nrow(respuestas) == 0) return(TRUE)
  required_cols <- c("pregunta", "respuesta")
  all(required_cols %in% names(respuestas))
}

#' Validar estructura de preguntas
#' @param preguntas data.frame
#' @return logical
#' @export
validate_questions <- function(preguntas) {
  if (!is.data.frame(preguntas)) return(FALSE)
  required_cols <- c("id_pregunta", "id_clase", "pregunta", "opciones", "correcta")
  all(required_cols %in% names(preguntas))
}
