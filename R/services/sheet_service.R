# ============================================================
# asiste
# Servicios Google Sheets (actualizado)
# ============================================================

#' Conectar Google Sheets
#' Inicializa autenticación.
#' @export
#'
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
#'
sheet_read <- function(sheet){

  cfg <- get_google_config()

  googlesheets4::read_sheet( ss = cfg$sheet_id,
                            sheet = sheet )
}

#' Agregar registros
#' @param sheet hoja destino.
#' @param data dataframe.
#' @export
#'
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
#'
sheet_get_students <- function(){

  cfg <- get_google_config()
  sheet_read( cfg$sheets$estudiantes )
}

#' Leer preguntas
#' @return preguntas.
#' @export
#'
sheet_get_questions <- function(){

  cfg <- get_google_config()
  sheet_read( cfg$sheets$preguntas )

}

#--------------------------------------------------------------
# Leer docentes / usuarios
#--------------------------------------------------------------

#' Obtener información de un docente
#' Busca un docente por correo electrónico.
#' @param email Correo institucional.
#' @return Lista con información del usuario o NULL.
#'
#' @export
#'
sheet_get_teacher <- function(email){

  cfg <- get_google_config()

  # Compatibilidad: preferimos la clave 'docentes' en config.yml pero
  # algunos desarrollos usan 'usuarios'. Buscamos ambas.
  sheet_name <- NULL
  if( !is.null(cfg$sheets$docentes) ) sheet_name <- cfg$sheets$docentes
  if( is.null(sheet_name) && !is.null(cfg$sheets$usuarios) ) sheet_name <- cfg$sheets$usuarios
  if( is.null(sheet_name) ) stop("No hay una hoja configurada para docentes/usuarios en config.yml")

  usuarios <- sheet_read(sheet_name)

  # Normalizar nombres de columnas para robustez (tolower sin espacios)
  col_names <- tolower(gsub("\n|\r|\s+", "", names(usuarios)))
  # Mapear columnas esperadas a las reales si es necesario
  email_col <- which(col_names == "email")
  activo_col <- which(col_names == "activo")

  if( length(email_col) == 0 ){
    stop("La hoja de docentes/usuarios no contiene una columna 'email'")
  }

  email_values <- usuarios[[email_col]]
  activo_values <- if( length(activo_col) ) usuarios[[activo_col]] else rep(TRUE, nrow(usuarios))

  # Buscar docente
  idx <- which(email_values == email & activo_values)

  if( length(idx) == 0 ) return(NULL)

  row <- usuarios[idx[1], , drop = FALSE]

  # Intentar extraer columnas comunes
  get_col <- function(df, names_vec){
    cn <- tolower(gsub("\n|\r|\s+", "", names(df)))
    for(nm in names_vec){
      pos <- which(cn == nm)
      if(length(pos)) return(df[[pos[1]]])
    }
    return(NA)
  }

  list(
    email = get_col(row, c("email")),
    nombre = get_col(row, c("nombre","name")),
    rol = get_col(row, c("rol","role")),
    comision = get_col(row, c("comision","commission"))
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
#'
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
#'
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
#'
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
#'
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
#' @' @return data.frame
#'
#' @export
#'
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
#'
sheet_get_attendance <- function(){

  cfg <- get_google_config()

  sheet_read( cfg$sheets$asistencia )
}

#--------------------------------------------------------------
# Leer respuestas
#--------------------------------------------------------------
#'
#' Leer respuestas
#' @return data.frame
#'
#' @export
#'
sheet_get_answers <- function(){

  cfg <- get_google_config()

  sheet_read( cfg$sheets$respuestas )

}
