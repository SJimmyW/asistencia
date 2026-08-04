FROM rocker/r-base:4.3.2

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    git \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy application files
COPY . /app/

# Install R packages using install2.r (more reliable)
RUN install2.r --error \
    shiny \
    bslib \
    googlesheets4 \
    purrr \
    config \
    digest

# Expose port
EXPOSE 3838

# Run the application
CMD ["R", "--no-save", "--quiet", "-e", "library(shiny); library(bslib); library(googlesheets4); library(purrr); library(config); library(digest); source_files <- list.files(path='R', pattern='\\\\.R$', recursive=TRUE, full.names=TRUE); invisible(lapply(source_files, source)); shiny::shinyApp(ui = app_ui(), server = app_server)"]
