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

  grepl(
    "^[0-9]{7,8}$", dni  )

}

# Compatibilidad: algunos módulos llaman a validate_student_dni()
# Definimos un alias para evitar romper la ejecución.
#' Validar DNI (compatibilidad)
#' @export
validate_student_dni <- function(dni){
  validate_dni(dni)
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
