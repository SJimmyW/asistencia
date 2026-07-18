# ============================================================
# asiste
# Gestión de permisos
# ============================================================

#' @title Gestión de permisos
#' @description
#' Centraliza todas las reglas de autorización de la aplicación.
#' Ningún módulo Shiny debe verificar directamente el rol del
#' usuario. Todas las decisiones deben pasar por este archivo.

#' @author SJWatson
#' @IA asistance: chatgpt
#' @keywords internal
NULL

#--------------------------------------------------------------
# Función auxiliar
#--------------------------------------------------------------

#' Verificar rol
#' @param role Rol requerido.
#' @return TRUE/FALSE.
#'
#' @keywords internal

has_role <- function(role){
  stopifnot(is.character(role))
  stopifnot(length(role) == 1)
  session_active() &&
    identical(current_role(), role)
}

#--------------------------------------------------------------
# Docente autenticado
#--------------------------------------------------------------

#' ¿Es docente?
#' @return TRUE/FALSE.
#'
#' @export

is_teacher <- function(){
  has_role("docente")
}

#--------------------------------------------------------------
# Estudiante
#--------------------------------------------------------------

#' ¿Es estudiante?
#' @return TRUE/FALSE.
#'
#' @export

is_student <- function(){
  has_role("estudiante")
}


#--------------------------------------------------------------
# Crear clases
#--------------------------------------------------------------

#' Permiso para crear clases.
#' @return TRUE/FALSE.
#'
#' @export

can_create_class <- function(){ # rol docente puede crearla. Podría agregarse que alguien más
  is_teacher()
}

#--------------------------------------------------------------
# Generar QR
#--------------------------------------------------------------

#' Permiso para generar códigos QR. Solo rol docente al momento. Modififable con roles en las gfuncionesio can-...
#' @return TRUE/FALSE.
#'
#' @export

can_generate_qr <- function(){
  is_teacher()
}

#--------------------------------------------------------------
# Administrar preguntas
#--------------------------------------------------------------

#' Permiso para administrar preguntas.
#' @return TRUE/FALSE.
#'
#' @export

can_manage_questions <- function(){
  is_teacher()
}

#--------------------------------------------------------------
# Dashboard asignatura
#--------------------------------------------------------------

#' Permiso para visualizar dashboards.
#' @return TRUE/FALSE.
#'
#' @export

can_view_dashboard <- function(){
  is_teacher()
}

#--------------------------------------------------------------
# Configuración
#--------------------------------------------------------------

#' Permiso para modificar configuración.
#' @return TRUE/FALSE.
#'
#' @export

can_edit_settings <- function(){
  is_teacher()
}

#--------------------------------------------------------------
# Registrar asistencia
#--------------------------------------------------------------

#' Permiso para registrar asistencia.
#' @return TRUE/FALSE.
#'
#' @export

can_register_attendance <- function(){
  TRUE
}
