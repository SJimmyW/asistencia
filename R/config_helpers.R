# ============================================================
# asiste
# Helpers para configuración de Google (cache simple)
# ============================================================
#
# Esta función devuelve la configuración cargada por run_app (options("asiste.config"))
# o carga config.yml si no está en memoria. Cachea el resultado por proceso.
#

.get_google_config_cached <- local({
  cfg_cached <- NULL
  function(force = FALSE) {
    if (!is.null(cfg_cached) && !force) return(cfg_cached)
    cfg <- getOption("asiste.config")
    if (is.null(cfg)) {
      # fallback a load_config()
      cfg <- load_config()
    }
    if (is.null(cfg)) stop("No se pudo cargar configuración (load_config returned NULL)")
    # asumimos que la estructura contiene sheet_id y sheets (como usa sheet_service)
    cfg_cached <<- cfg
    cfg_cached
  }
})

get_google_config <- function(force = FALSE) {
  # devuelve la configuración completa esperada por sheet_service (cfg$sheet_id, cfg$sheets, etc.)
  .get_google_config_cached(force = force)
}
