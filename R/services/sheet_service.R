# ============================================================
# asiste
# Servicio Google Sheets
# ============================================================

#' Conectar Google Sheets
#' Inicializa autenticación.
#' @export
#
sheet_connect <- function(){

  cfg <- get_google_config()

  if( is.null(cfg$sheet_id) || cfg$sheet_id == "" ){

    stop( "No se configuró Google Sheet" )
  }

  googlesheets4::gs4_auth()
  TRUE
}

#' Leer una hoja
#' @param sheet nombre de hoja.
#' @return dataframe.
#' @export

sheet_read <- function(sheet){

  cfg <- get_google_config()

  googlesheets4::read_sheet( ss = cfg$sheet_id,
                            sheet = sheet )
}

#' Agregar registros
#' @param sheet hoja destino.
#' @param data dataframe.
#' @export
#
sheet_append <- function( sheet, 
                         data ){

  cfg <- get_google_config()

  googlesheets4::sheet_append(

    ss = cfg$sheet_id,
    data = data,
    sheet = sheet )

}

#' Leer estudiantes
#' Función específica del dominio.
#' @return estudiantes.
#' @export
#

sheet_get_students <- function(){

  cfg <- get_google_config()
  sheet_read( cfg$sheets$estudiantes )
}


#' Leer preguntas
#' @return preguntas.
#' @export
#

sheet_get_questions <- function(){

  cfg <- get_google_config()
  sheet_read( cfg$sheets$preguntas )

}

#--------------------------------------------------------------
# Leer docentes
#--------------------------------------------------------------

#' Obtener información de un docente
#' Busca un docente por correo electrónico.
#' @param email Correo institucional.
#' @return Lista con información del usuario o NULL.
#'
#' @export

sheet_get_teacher <- function(email){

  cfg <- get_google_config()
  usuarios <- sheet_read(cfg$sheets$usuarios)
  docente <- usuarios[
    usuarios$email == email &
      usuarios$activo,
  ]

  if(nrow(docente) == 0){
    return(NULL)
  }

  list(
    email = docente$email[[1]],
    nombre = docente$nombre[[1]],
    rol = docente$rol[[1]],
    comision = docente$comision[[1]]
  )
}
