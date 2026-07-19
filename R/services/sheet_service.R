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

#--------------------------------------------------------------
# Leer preguntas de una clase
#--------------------------------------------------------------

#' Obtener preguntas de una clase
#' @param id_clase Identificador de la clase.
#'
#' @return data.frame
#'
#' @export

sheet_get_questions_class <- function(id_clase){
  
  preguntas <- sheet_get_questions()
  preguntas[ preguntas$id_clase == id_clase, ]

}

#--------------------------------------------------------------
# Registrar asistencia
#--------------------------------------------------------------

#' Guardar asistencia de un estudiante
#' @param id_clase Clase.
#' @param dni DNI.
#' @param fecha_hora Fecha y hora.
#' @param puntos Puntaje obtenido.
#'
#' @export

sheet_save_attendance <- function(
    id_clase,
    dni,
    fecha_hora = Sys.time(),
    puntos = 0
){

  cfg <- get_google_config()

  registro <- data.frame( id_clase = id_clase,
                         DNI = dni,
                         fecha_hora = fecha_hora,
                         puntos = puntos,
                         stringsAsFactors = FALSE )

  sheet_append( sheet = cfg$sheets$asistencia, 
               data = registro )
}

#--------------------------------------------------------------
# Guardar respuestas
#--------------------------------------------------------------

#' Guardar respuestas de un estudiante
#' @param respuestas data.frame.
#'
#' @export

sheet_save_answers <- function(respuestas){

  cfg <- get_google_config()
  sheet_append( sheet = cfg$sheets$respuestas,
               data = respuestas )
}

#--------------------------------------------------------------
# Escribir hoja completa
#--------------------------------------------------------------

#' Sobrescribir una hoja del Google Sheets
#' @param sheet Nombre de la hoja.
#' @param data data.frame.
#'
#' @export

sheet_write <- function( sheet,
                        data ){

  cfg <- get_google_config()
  googlesheets4::sheet_write( data = data,
                             ss = cfg$sheet_id,
                             sheet = sheet )
}

#--------------------------------------------------------------
# Leer una clase
#--------------------------------------------------------------

#' Obtener información de una clase
#' @param id_clase Clase.
#' @return data.frame
#'
#' @export

sheet_get_class <- function(id_clase){
  
  cfg <- get_google_config()
  clases <- sheet_read( cfg$sheets$clases )

  clases[ clases$id_clase == id_clase, ]
}
#--------------------------------------------------------------
# Leer asistencia
#--------------------------------------------------------------

#' Leer asistencias
#' @return data.frame
#'
#' @export

sheet_get_attendance <- function(){

  cfg <- get_google_config()

  sheet_read( cfg$sheets$asistencia )
}

#--------------------------------------------------------------
# Leer respuestas
#--------------------------------------------------------------

#' Leer respuestas
#' @return data.frame
#'
#' @export

sheet_get_answers <- function(){

  cfg <- get_google_config()

  sheet_read( cfg$sheets$respuestas )

}
