# ============================================================
# asiste
# Variables globales y opciones generales
# ============================================================


#' Nombre de la aplicación
APP_NAME <- "asiste"

#' Versión actual
APP_VERSION <- "0.1.0"

#' Opciones globales de la aplicación
#'
#' Se inicializan al cargar el paquete.

.onLoad <- function(libname, pkgname) {

  options(
    asiste.name = APP_NAME,
    asisteUNRC.version = APP_VERSION
  )

}
