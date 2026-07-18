#--------------------------------------------------------------
# Guardar asistencia
#--------------------------------------------------------------

#' Registrar asistencia
#' @param id_clase Clase.
#' @param dni DNI.
#' @param puntos Puntaje obtenido.
#'
#' @export

sheet_save_attendance <- function(
    id_clase,
    dni,
    puntos
){
    registro <- data.frame( id_clase=id_clase,
                           DNI=dni,
                           fecha_hora=Sys.time(),
                           puntos=puntos )

    cfg <- get_google_config()

    sheet_append( sheet=cfg$sheets$asistencia,
                 data=registro )
}
