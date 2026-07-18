# ============================================================
# asiste
# Servicio Google Sheets (modificado para delegar en cache/cola)
# ============================================================

# Mantener firma pública: sheet_connect, sheet_read, sheet_append, sheet_get_* , sheet_get_teacher

# Conectar Google Sheets
sheet_connect <- function(){

  cfg <- get_google_config()

  if( is.null(cfg$sheet_id) || cfg$sheet_id == "" ){
    stop( "No se configuró Google Sheet" )
  }

  # En producción recomendamos autenticación con cuenta de servicio:
  # gargle::credentials_service_account(path = "path/to/service-account.json")
  googlesheets4::gs4_auth()
  TRUE
}

# Leer una hoja (delegado a la versión cacheada)
sheet_read <- function(sheet){
  # sheet_read mantiene la firma para compatibilidad.
  # sheet_read_cached debe existir (definida en R/services/sheet_cache.R)
  sheet_read_cached(sheet)
}

# Agregar registros (encola para batch)
sheet_append <- function(sheet, data, flush_immediately = FALSE) {
  if (isTRUE(flush_immediately)) {
    sheet_append_batched(sheet = sheet, data = data)
  } else {
    enqueue_row(sheet = sheet, row = data)
  }
  invisible(TRUE)
}

# Leer estudiantes
sheet_get_students <- function(){
  cfg <- get_google_config()
  sheet_read(cfg$sheets$estudiantes)
}

# Leer preguntas
sheet_get_questions <- function(){
  cfg <- get_google_config()
  sheet_read(cfg$sheets$preguntas)
}

# Obtener información de un docente
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
