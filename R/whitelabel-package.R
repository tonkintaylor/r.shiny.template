#' @keywords internal
"_PACKAGE"

## usethis namespace: start
#' @importFrom fresh adminlte_color adminlte_global create_theme
#' @importFrom golem add_resource_path bundle_resources favicon with_golem_options
#' @importFrom shiny fluidPage moduleServer NS plotOutput renderPlot shinyApp sidebarLayout sliderInput tagList
## usethis namespace: end
NULL

# Suppress R CMD check notes for tidyverse data masking pronoun
utils::globalVariables(c(".data"))