# ============================================================
# asiste
# Gestión de sesión
# ============================================================

#' @title Gestión de sesión
#' @description
#' Administra la información del usuario autenticado durante
#' la sesión Shiny.
#' El resto de la aplicación nunca accede directamente a
#' Google OAuth ni a Google Sheets.
#' Siempre consulta este servicio.
#'
#' @author
#' SJWatson
#'Asitencia IA: chatgpt
#' @keywords internal
NULL

#--------------------------------------------------------------
# Estado interno
#--------------------------------------------------------------

.session <- new.env(parent = emptyenv())
.session$user <- NULL

#--------------------------------------------------------------
# Iniciar sesión
#--------------------------------------------------------------

#' Iniciar sesión de usuario
#' Guarda la información del usuario autenticado.
#' @param user Lista con información del usuario.
#' @return Invisiblemente TRUE.
#' @export

session_start <- function(user){

  stopifnot(is.list(user))
  .session$user <- user
  invisible(TRUE)
}

#--------------------------------------------------------------
# Finalizar sesión
#--------------------------------------------------------------

#' Finalizar sesión
#' Elimina el usuario de la sesión.
#' @return Invisiblemente TRUE.
#' @export

session_end <- function(){
  .session$user <- NULL
  invisible(TRUE)
}

#--------------------------------------------------------------
# Usuario actual
#--------------------------------------------------------------

#' Usuario autenticado
#' Devuelve la información del usuario autenticado.
#' @return Lista o NULL.
#'
#' @export

current_user <- function(){
  .session$user
}

#--------------------------------------------------------------
# ¿Existe sesión?
#--------------------------------------------------------------

#' Verificar sesión
#' @return TRUE/FALSE.
#'
#' @export

session_active <- function(){
  !is.null(.session$user)
}

#--------------------------------------------------------------
# Obtener rol
#--------------------------------------------------------------

#' Rol del usuario
#' @return character o NULL.
#'
#' @export

current_role <- function(){
  if(!session_active()){
    return(NULL)
  }
  .session$user$rol
}

#--------------------------------------------------------------
# Obtener nombre
#--------------------------------------------------------------

#' Nombre del usuario
#' @return character o NULL.
#'
#' @export

current_name <- function(){
  if(!session_active()){
    return(NULL)
  }
  .session$user$nombre
}

#--------------------------------------------------------------
# Obtener email
#--------------------------------------------------------------

#' Email del usuario
#' @return character o NULL.
#'
#' @export

current_email <- function(){

  if(!session_active()){
    return(NULL)
  }
  .session$user$email
}

#--------------------------------------------------------------
# Obtener asignaturas
#--------------------------------------------------------------

#' Asignaturas del docente
#' @return Vector de caracteres.
#'
#' @export

current_subjects <- function(){

  if(!session_active()){
    return(character())
  }
  .session$user$asignaturas

}
