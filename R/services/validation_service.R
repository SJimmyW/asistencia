# ============================================================
# asiste
# Validaciones generales
# ============================================================

#' Validar estructura DNI
#' No verifica existencia, solo el formato.
#'
#' @param dni DNI estudiante.
#' @return TRUE/FALSE
#' @export
#'

validate_student_dni <- function(dni){

  if( length(dni) != 1 ){
    return(FALSE)
  }

  grepl( "^[0-9]{7,8}$", dni )

}

#' Validar campos obligatorios
#' @param data lista o dataframe.
#' @param fields campos requeridos.
#' @return TRUE/FALSE
#' @export
#'

validate_required_fields <- function(
    data,
    fields ){ 
  all( fields %in% names(data) )
}

#' Validar ventana horaria
#' Controla acceso QR.
#' @param inicio inicio permitido.
#' @param fin cierre permitido.
#' @param actual hora actual.
#'
#' @return TRUE/FALSE
#' @export
#'

validate_time_window <- function(
    inicio,
    fin,
    actual = Sys.time() ){

  actual >= inicio &&
    actual <= fin

}
