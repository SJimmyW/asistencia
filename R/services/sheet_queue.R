# ============================================================
# asiste
# Cola y flush para escrituras a Google Sheets
# ============================================================
#
# Patrón simple en memoria (por proceso). Para despliegues multi-process
# cada proceso tendrá su propia cola. Si se requiere persistencia/centralización
# usar Redis / DB.
#

# entorno para guardar la cola y estado
sheet_write_queue_env <- new.env(parent = emptyenv())
sheet_write_queue_env$queue <- list()
sheet_write_queue_env$locked <- FALSE

# Enqueue: recibe un data.frame (1 fila) o una lista con campos
enqueue_row <- function(sheet, row) {
  entry <- list(sheet = sheet, row = row)
  sheet_write_queue_env$queue <- append(sheet_write_queue_env$queue, list(entry))
  invisible(NULL)
}

# Flush: agrupa por hoja y hace un único sheet_append por hoja
flush_queue_once <- function() {
  if (length(sheet_write_queue_env$queue) == 0) return(invisible(NULL))
  if (sheet_write_queue_env$locked) return(invisible(NULL))
  sheet_write_queue_env$locked <- TRUE
  on.exit(sheet_write_queue_env$locked <- FALSE)

  q <- sheet_write_queue_env$queue
  sheet_write_queue_env$queue <- list() # limpiamos para aceptar nuevos

  # agrupar por nombre de hoja
  grouped <- split(q, vapply(q, `[[`, "", "sheet"))
  for (sheet_name in names(grouped)) {
    rows <- lapply(grouped[[sheet_name]], `[[`, "row")
    # convertir a data.frame (asegurando strings no-factor)
    df_rows <- lapply(rows, function(r) {
      if (is.data.frame(r)) return(r)
      as.data.frame(r, stringsAsFactors = FALSE)
    })
    df <- do.call(rbind, df_rows)
    # llamada batch (usa retry wrapper)
    sheet_append_batched(sheet = sheet_name, data = df)
  }
  invisible(NULL)
}

# Implementación de append batched: una única llamada por data.frame
sheet_append_batched <- function(sheet, data) {
  cfg <- get_google_config()
  retry_with_backoff(function() {
    googlesheets4::sheet_append(ss = cfg$sheet_id, data = data, sheet = sheet)
  })
}
