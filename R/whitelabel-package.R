#' @keywords internal
"_PACKAGE"

## usethis namespace: start
#' @importFrom bslib card card_body card_header
#' @importFrom fresh adminlte_color adminlte_global create_theme use_theme
#' @importFrom golem activate_js add_resource_path bundle_resources favicon with_golem_options
#' @importFrom shinydashboard dashboardBody menuItem menuSubItem sidebarMenu tabItem valueBoxOutput renderValueBox valueBox tabItems
#' @importFrom shinydashboardPlus box dashboardControlbar dashboardFooter dashboardHeader dashboardPage dashboardSidebar controlbarItem controlbarMenu
#' @importFrom shiny actionButton br checkboxInput column conditionalPanel div fluidRow h2 h5 HTML icon moduleServer NS observeEvent p plotOutput reactive reactiveVal renderPlot req selectInput shinyApp showNotification sliderInput tagList tags testServer updateSliderInput
## usethis namespace: end
NULL

# Suppress R CMD check notes for tidyverse data masking pronoun
utils::globalVariables(c(".data"))