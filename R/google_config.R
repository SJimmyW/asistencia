# ============================================================
# asiste
# Google / Config helpers and validation
# ============================================================

#' Obtener la configuración de Google (sheet_id + nombres de hojas)
#'
#' Devuelve la lista cfg$google tomada de config.yml (modo desarrollo) o
#' del paquete (fallback).
#'
#' @return Lista con elementos: sheet_id, sheets (lista de nombres)
#' @export
get_google_config <- function(){

  cfg <- NULL
  # Intentar usar load_config si existe
  if( exists("load_config") ){
    cfg_full <- load_config()
  } else {
    cfg_full <- config::get(file = "config.yml")
  }

  if( !is.null(cfg_full$google) ){
    return(cfg_full$google)
  }

  stop("No se encontró la configuración de Google en config.yml")
}


#' Verificar que las hojas y columnas esperadas existen en el Google Sheet.
#'
#' Esta función realiza verificaciones básicas en tiempo de arranque para
#' asegurar que las hojas mencionadas en config.yml estén presentes y que
#' incluyan las columnas mínimas requeridas.
#'
#' @param cfg Opcional. Resultado de load_config() (útil para evitar recargar).
#' @param stop_on_error Si TRUE, detiene la ejecución con stop() si hay errores.
#' @return Lista con el resultado de la verificación (invisible TRUE si todo ok).
#' @export
validate_sheets <- function(cfg = NULL, stop_on_error = TRUE){

  if( is.null(cfg) ){
    cfg <- load_config()
  }

  gcfg <- cfg$google

  if( is.null(gcfg$sheet_id) || gcfg$sheet_id == "" ){
    msg <- "Google Sheet ID no configurado en config.yml."
    if( stop_on_error ) stop(msg) else return(list(ok=FALSE, errors=msg))
  }

  ss <- gcfg$sheet_id

  # Intentar obtener nombres de hojas
  sheets_remote <- tryCatch(
    googlesheets4::sheet_names(ss),
    error = function(e) e
  )

  if( inherits(sheets_remote, "error") ){
    msg <- paste0("No se pudo acceder al Google Sheet '", ss, "': ", sheets_remote$message)
    if( stop_on_error ) stop(msg) else return(list(ok=FALSE, errors=msg))
  }

  expected_sheets <- unlist(gcfg$sheets)

  missing_sheets <- setdiff(expected_sheets, sheets_remote)

  errors <- list()

  if( length(missing_sheets) > 0 ){
    errors <- c(errors, paste0("Faltan hojas en el Google Sheet: ", paste(missing_sheets, collapse = ", "))) 
  }

  # Definir columnas esperadas por hoja (en minúsculas para comparación)
  expected_columns <- list(
    docentes = c("email", "nombre", "rol", "comision", "activo"),
    estudiantes = c("dni", "nombre", "email"),
    clases = c("id_clase"),
    preguntas = c("id_pregunta", "id_clase"),
    asistencia = c("id_clase", "dni", "fecha_hora"),
    respuestas = c("id_clase", "dni", "id_pregunta")
  )

  # Para cada hoja esperada, comprobar columnas mínimas si la hoja existe
  for( sheet_key in names(gcfg$sheets) ){
    sheet_name <- gcfg$sheets[[sheet_key]]
    if( !(sheet_name %in% sheets_remote) ) next

    # leer solo los nombres de columna (n_max = 0)
    header <- tryCatch(
      names(googlesheets4::read_sheet(ss = ss, sheet = sheet_name, n_max = 0)),
      error = function(e) e
    )

    if( inherits(header, "error") ){
      errors <- c(errors, paste0("No se pudo leer la hoja '", sheet_name, "': ", header$message))
      next
    }

    header_norm <- tolower(gsub("\n|\r|\s+", "", header))

    key_lower <- tolower(sheet_key)
    exp_cols <- expected_columns[[key_lower]]

    if( !is.null(exp_cols) ){
      exp_norm <- tolower(exp_cols)
      missing_cols <- setdiff(exp_norm, header_norm)
      if( length(missing_cols) > 0 ){
        errors <- c(errors, paste0("Hoja '", sheet_name, "' falta columnas: ", paste(missing_cols, collapse = ", "))) 
      }
    }
  }

  if( length(errors) > 0 ){
    if( stop_on_error ){
      stop(paste(errors, collapse = "\n"))
    } else {
      return(list(ok = FALSE, errors = errors))
    }
  }

  invisible(list(ok = TRUE))
}
