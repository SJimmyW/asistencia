# ============================================================
# asiste
# Servicio de autenticación
# ============================================================
#' @title Servicio de autenticación
#' @description
#' Funciones relacionadas con la autenticación del docente.
#'
#' Este módulo abstrae completamente el mecanismo de login.
#' Actualmente utiliza una implementación temporal.
#' En futuras versiones podrá reemplazarse por Google OAuth
#' sin modificar el resto de la aplicación.
#'
#' @author
#' SJWatson
#'
#' @keywords internal
NULL

#--------------------------------------------------------------
# Estado interno
#--------------------------------------------------------------

.auth_state <- new.env(parent = emptyenv())
.auth_state$logged <- FALSE
.auth_state$email  <- NULL

#--------------------------------------------------------------
# Login
#--------------------------------------------------------------

#' Iniciar sesión
#' Inicia la autenticación del docente.
#' Actualmente implementa un login simulado.
#' En futuras versiones abrirá el flujo OAuth de Google.
#' @return Invisiblemente TRUE/FALSE.
#'
#' @export

login_teacher <- function(){ .auth_state$logged <- TRUE
                            invisible(TRUE)
}

#--------------------------------------------------------------
# Logout
#--------------------------------------------------------------

#' Finalizar sesión
#' Elimina la información de autenticación.
#' @return Invisiblemente TRUE.
#'
#' @export

logout_teacher <- function(){

  .auth_state$logged <- FALSE
  .auth_state$email <- NULL
  invisible(TRUE)

}

#--------------------------------------------------------------
# Estado
#--------------------------------------------------------------

#' ¿Existe una sesión iniciada?
#' @return TRUE/FALSE
#'
#' @export

is_authenticated <- function(){

  isTRUE(.auth_state$logged)

}

#--------------------------------------------------------------
# Email
#--------------------------------------------------------------

#' Obtener email autenticado
#' Devuelve el email del docente autenticado.
#' @return character o NULL.
#'
#' @export

get_teacher_email <- function(){
  .auth_state$email
}

#--------------------------------------------------------------
# Asignar email
#--------------------------------------------------------------

#' Registrar email autenticado
#' Función utilizada por el backend de autenticación.
#' @param email Dirección institucional.
#' @return Invisiblemente TRUE.
#'
#' @keywords internal

set_teacher_email <- function(email){

  stopifnot(is.character(email))
  stopifnot(length(email) == 1)
  .auth_state$email <- email
  invisible(TRUE)

}
