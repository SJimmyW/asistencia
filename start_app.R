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
  pattern = "\\.R$",
  recursive = TRUE,
  full.names = TRUE
)

invisible(lapply(source_files, source))

# Run the app
shiny::shinyApp(ui = app_ui(), server = app_server)
