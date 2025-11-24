#!/usr/bin/env Rscript

#' Deploy Golem Application to shinyapps.io
#'
#' Minimal deployment script using credentials from .Renviron
#'
#' Required in .Renviron:
#'   SHINYAPPS_NAME="your-account-name"
#'   SHINYAPPS_TOKEN="your-token"
#'   SHINYAPPS_SECRET="your-secret"

# Load packages
library(rsconnect)
library(desc)

# Configure renv to suppress validation errors for unknown package sources
# This prevents deployment failure when the local Golem package is detected
Sys.setenv(RENV_CONFIG_SNAPSHOT_VALIDATE = "FALSE")
options(renv.warnings.unknown_sources = FALSE)

# Note: The package is now installed via remotes::install_local() in the CI workflow
# (see .github/workflows/deploy-shinyapps.yaml) before this script runs.
# This ensures system.file() and other package-aware functions work correctly.

# Load credentials from .Renviron
if (file.exists(".Renviron")) readRenviron(".Renviron")

# Add shinyapps.io deployment file
golem::add_shinyappsio_file(open = FALSE)

# Deploy
# Use appPrimaryDoc to treat this as a document deployment (not a package)
# This prevents rsconnect from trying to reinstall the r1099894 package
rsconnect::setAccountInfo(name = Sys.getenv('SHINYAPPS_NAME'), token = Sys.getenv('SHINYAPPS_TOKEN'), secret = Sys.getenv('SHINYAPPS_SECRET'))
rsconnect::deployApp(appName = Sys.getenv('SHINYAPPS_APPNAME'), forceUpdate = TRUE, logLevel = 'normal', launch.browser = FALSE, appMode = "shiny")
