# ============================================================
# asiste
# Servicio de configuración
# ============================================================

#' Obtener configuración de la aplicación
#' Wrapper para acceder a config.yml.
#'
#' @return Lista de configuración.
#' @export
#'

get_app_config <- function(){

  if( is.null( getOption("asiste.config") ) ){

    cfg <- config::get() #cfg <- load_config()
    options( asiste.config = cfg)
  }

  getOption( "asiste.config" ) }

#' Obtener configuración Google Sheets
#' @return configuración Google.
#'
#' @export

get_google_config <- function(){

  cfg <- get_app_config()

  cfg$google
}
