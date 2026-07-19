# ============================================================
# asiste
# Gestión de configuración
# ============================================================

#' Leer configuración del proyecto
#'
#' Lee config.yml usando el paquete config.
#'
#' Prioridad de lectura:
#' 1) archivo `config.yml` en el directorio del repositorio (modo desarrollo)
#' 2) archivo embebido en el paquete (si la app se instala como paquete)
#'
#' @return Lista con configuración.
#' @export

load_config <- function() {

  # Preferir el config.yml local para desarrollo (clon del repo)
  if (file.exists("config.yml")) {
    cfg <- config::get(file = "config.yml")
    message("Usando config.yml local")
  } else {
    # Fallback: cuando se instala como paquete (no es el caso si se usa como app)
    cfg <- config::get(
      file = system.file(
        "config.yml",
        package = "asiste"
      )
    )
    message("Usando config.yml embebido en el paquete (system.file)")
  }

  # Avisos útiles para desarrollo
  if (is.null(cfg$google$sheet_id) || cfg$google$sheet_id == ""){
    warning("Google Sheet ID no configurado. Edita config.yml y agrega google: sheet_id: '<ID_del_sheet>'")
  }

  cfg
}
