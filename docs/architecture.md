# Architecture

The application follows one central principle:

Google Sheets stores the data.

Shiny displays and edits the data.

Business logic remains inside the R package.

The user never edits code.
Configuration belongs in Google Sheets.
