# ============================================================
# asiste
#
# Copyright (C) 2026 SJWatson
# License: GPL-3.0
# Repository: https://github.com/SJimmyW/asistencia
# ============================================================

#--------------------------------------------------------------
# Corrección de preguntas
#--------------------------------------------------------------

#' Corregir respuestas de un estudiante
#' @param preguntas data.frame leído desde la hoja Preguntas.
#' @param respuestas data.frame generado por mod_questions().
#'
#' @return Lista con resultados.
#'
#' @export

grade_answers <- function(
    preguntas,
    respuestas
){

    if(nrow(preguntas)==0){

        return( list( correct_answers=0,
                     total_questions=0,
                     total_points=0,
                     score_percent=100,
                     answers=data.frame() ) )
    }

    res <- merge( preguntas, respuestas, by="pregunta",
                 sort=FALSE )

    res$correcta <- res$respuesta==res$correcta
    res$puntos_obtenidos <- ifelse( res$correcta, res$puntos, 0 )

    list( correct_answers = sum(res$correcta),
         total_questions = nrow(res),
         total_points = sum(res$puntos_obtenidos),
         score_percent = 100 * sum(res$puntos_obtenidos)/ sum(res$puntos),
         answers = res )
}

#--------------------------------------------------------------
# Estadísticas alumno
#--------------------------------------------------------------

#' Calcular estadísticas de un alumno
#' @param dni DNI.
#' @param asistencia Hoja Asistencia.
#' @param respuestas Hoja Respuestas.
#'
#' @export

student_statistics <- function(
  dni,
  asistencia,
  respuestas){

    a <- asistencia[ asistencia$DNI==dni, ]
    r <- respuestas[ respuestas$DNI==dni, ]

    list( attendance=nrow(a),
         points=sum(r$puntos),
         correct=sum(r$correcta),
         total=nrow(r) )
}

#--------------------------------------------------------------
# Estadísticas clase
#--------------------------------------------------------------

#' Estadísticas de una clase
#' @param id_clase Clase.
#' @param asistencia Hoja Asistencia.
#' @param respuestas Hoja Respuestas.
#'
#' @export

class_statistics <- function( id_clase,
                             asistencia,
                             respuestas

){

    a <- asistencia[ asistencia$id_clase==id_clase, ]

    r <- respuestas[ respuestas$id_clase==id_clase, ]

    list( presentes=nrow(a),
         promedio= mean( r$correcta, na.rm=TRUE ) )

}

#--------------------------------------------------------------
# Actualizar hoja Estudiantes
#--------------------------------------------------------------

#' Actualizar estadísticas de estudiantes
#'
#' @export

update_student_statistics <- function(){
  
  alumnos <- sheet_read( "Estudiantes" )

    asistencia <- sheet_read( "Asistencia" )

    respuestas <- sheet_read( "Respuestas" )

    for(i in seq_len(nrow(alumnos))){

        s <- student_statistics( alumnos$DNI[i],
                                asistencia,
                                respuestas )

        alumnos$`N° clases presentes`[i] <- s$attendance

        alumnos$`N° puntos`[i] <- s$points

    }

    sheet_write( "Estudiantes", alumnos )

}
