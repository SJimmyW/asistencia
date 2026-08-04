FROM rocker/shiny:4.3.2

# Install additional system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy application files
COPY . /app/

# Install additional R packages
RUN R -e "install.packages(c('bslib', 'googlesheets4', 'purrr', 'config', 'digest'), repos='http://cran.rstudio.com/', dependencies=TRUE)"

# Expose port
EXPOSE 3838

# Run the startup script
CMD ["Rscript", "start_app.R"]
