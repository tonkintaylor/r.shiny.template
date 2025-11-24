###############################################################################
# Run Golem Application Locally with Hot Reload
###############################################################################

# Set development options for hot reload
options(
  shiny.autoreload = TRUE,
  shiny.port = 8000
)     

# Load the package in development mode
pkgload::load_all(here::here(), export_all = FALSE, export_imports = FALSE)

# Configure golem with development settings
golem::with_golem_options(
  app = shinyApp(
    ui = app_ui,
    server = app_server
  ),
  golem_opts = list(
    app_prod = FALSE  # Development mode
  )
)

