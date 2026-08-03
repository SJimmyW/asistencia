# ============================================================
# asiste
# Utilidades generales
# ============================================================

#' Operador NULL-coalesce
#' Si x es NULL, devuelve y. Si no, devuelve x.
#' @keywords internal
`%||%` <- function(x, y) {
  if (is.null(x)) y else x
}
