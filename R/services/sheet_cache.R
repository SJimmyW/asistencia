# ============================================================
# asiste
# Caching / memoización para read_sheet
# ============================================================
#
# Requiere: memoise, cachem
#
# Implementa sheet_read_cached(sheet) con TTL (max_age).
#

# avoid attaching libraries in package code; use requireNamespace checks
if (!requireNamespace("memoise", quietly = TRUE)) {
  stop("Package 'memoise' is required. Install with install.packages('memoise')")
}
if (!requireNamespace("cachem", quietly = TRUE)) {
  stop("Package 'cachem' is required. Install with install.packages('cachem')")
}

# función no cacheada que hace la lectura real
.sheet_read_uncached <- function(sheet) {
  cfg <- get_google_config()
  googlesheets4::read_sheet(ss = cfg$sheet_id, sheet = sheet)
}

# Creador de función cacheada con TTL en segundos
sheet_read_create_cached <- function(ttl = 300) {
  cache <- cachem::cache_mem(max_age = ttl)
  memoise::memoise(.sheet_read_uncached, cache = cache)
}

# Inicializa la función cacheada con TTL por defecto (5 minutos)
# Al cargar el paquete/archivo, se crea la función sheet_read_cached
sheet_read_cached <- sheet_read_create_cached(ttl = 300)

# Invalidate / forget (útil para refrescar manualmente)
sheet_read_invalidate <- function() {
  memoise::forget(sheet_read_cached)
}

# export: sheet_read_cached, sheet_read_invalidate
