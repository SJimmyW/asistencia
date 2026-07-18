# ============================================================
# asiste
# Gestión de configuración
# ============================================================

#' Leer configuración del proyecto
#'
#' Lee config.yml usando el paquete config.
#'
#' @return Lista con configuración.
#' @export

load_config <- function() {

  config::get(
    file = system.file(
      "config.yml",
      package = "asiste"
    )
  )

}
