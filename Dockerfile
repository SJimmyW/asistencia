FROM rocker/r-base:4.3.2

# Install system dependencies without version conflicts
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    git \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy application files
COPY . /app/

# Install R packages
RUN R -e "options(repos='http://cran.rstudio.com/'); \
          pkgs <- c('shiny', 'bslib', 'googlesheets4', 'purrr', 'config', 'digest'); \
          install.packages(pkgs, dependencies=TRUE)"

# Expose port
EXPOSE 3838

# Run the application
CMD ["R", "--no-save", "--quiet", "-e", "source('R/run_app.R'); run_app(host='0.0.0.0', port=3838)"]
