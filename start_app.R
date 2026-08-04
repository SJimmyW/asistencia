#!/usr/bin/env Rscript

# Load libraries
library(shiny)
library(bslib)
library(googlesheets4)
library(purrr)
library(digest)

# Source all R files
source_files <- list.files(
  path = "R",
  pattern = "\\.[Rr]$",
  recursive = TRUE,
  full.names = TRUE
)

invisible(lapply(source_files, source))

# Run the app using run_app() which handles config, validation, and startup
run_app(host = "0.0.0.0", port = 3838)
