# ============================================================
# asiste
# Utilidad: retry con backoff y logging simple
# ============================================================

retry_with_backoff <- function(fun,
                               max_attempts = 5,
                               initial_delay = 0.5,
                               factor = 2,
                               verbose = TRUE) {
  attempt <- 1
  delay <- initial_delay
  repeat {
    try_res <- tryCatch({
      val <- fun()
      list(success = TRUE, result = val)
    }, error = function(e) {
      list(success = FALSE, error = e)
    })
    if (try_res$success) {
      if (verbose) message(sprintf("[sheets] intento %d OK", attempt))
      return(try_res$result)
    } else {
      if (verbose) message(sprintf("[sheets] intento %d falló: %s", attempt, try_res$error$message))
      if (attempt >= max_attempts) {
        if (verbose) message("[sheets] alcanzado max_attempts, re-lanzando error")
        stop(try_res$error)
      }
      sleep_time <- delay * runif(1, 0.8, 1.2)
      if (verbose) message(sprintf("[sheets] retry en %.2fs", sleep_time))
      Sys.sleep(sleep_time)
      attempt <- attempt + 1
      delay <- delay * factor
    }
  }
}
