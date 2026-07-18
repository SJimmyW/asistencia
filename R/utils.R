# ============================================================
# asiste
# Funciones auxiliares
# ============================================================

#' Validar DNI estudiante
#'
#' El DNI debe contener solamente números.
#'
#' Ejemplo válido: 34567890
#' Ejemplos inválidos: 34.567.890
#'
#' @param dni DNI ingresado.
#'
#' @return TRUE/FALSE
#'
#' @export


validate_dni <- function(dni) {

  grepl(  #' buscar coincidencias de texto mediante expresiones regulares. Devuelve un vector lógico (TRUE si el patrón existe en el elemento, FALSE si no)
    "^[0-9]{7,8}$", dni  )

}

#' Formatear porcentaje
#' @param x valor decimal.
#'
#' @return porcentaje.
#'
#' @export

format_percent <- function(x){

  paste0( round(x * 100, 2),  "%"  )

}
