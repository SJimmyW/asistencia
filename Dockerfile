FROM r-base:4.3.2

# Install system dependencies
RUN apt-get update && apt-get install -y \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    git \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy application files
COPY . /app/

# Install R packages with retries
RUN R -e "options(repos='http://cran.rstudio.com/'); \
          packages <- c('shiny', 'bslib', 'googlesheets4', 'purrr', 'config', 'digest'); \
          for (pkg in packages) { \
            if (!require(pkg, character.only = TRUE)) { \
              install.packages(pkg, dependencies = TRUE) \
            } \
          }"

# Expose port
EXPOSE 3838

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=40s --retries=3 \
    CMD curl -f http://localhost:3838 || exit 1

# Run the application
CMD ["R", "--no-save", "--quiet", "-e", "source('R/run_app.R'); run_app(host='0.0.0.0', port=3838)"]
