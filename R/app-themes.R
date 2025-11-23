# ============================================================================
# Main Theme Function
# ============================================================================

#' Create Application Theme
#'
#' Creates a custom theme for the Pūwaiwaha dashboard using the `fresh` package.
#' Defines colors for input and output boxes, the page header, and footer to maintain
#' visual consistency across the application.
#'
#' Colour constants are defined in `app-themes-constants.R`.
#'
#' @return A theme object suitable for use with `fresh::use_theme()` in dashboardBody
#'
#' @details
#' This theme customizes AdminLTE color variables:
#' - `light_blue`: Controls the header and footer background colour
#' - `aqua`: Remapped to input boxes via `status = "info"` (Transfer Coefficients)
#' - `orange`: Maps to output boxes via `status = "warning"` (Depletion Curves)
#'
#' Footer styling is applied via custom CSS (`get_footer_css()`) to match the header.
#'
#' @noRd
create_app_theme <- function() {
  create_theme(
    adminlte_color(
      light_blue = HEADER_FOOTER_BG_COLOR,  # Header and footer background
      aqua = INFO_BOX_COLOR,                # Info status → Input boxes
      orange = OUTPUT_BOX_COLOR             # Warning status → Output boxes
    ),
    adminlte_global(
      content_bg = CONTENT_BG_COLOR,  # Dashboard body background
      box_bg = BOX_BG_COLOR            # Box content background
    )
  )
}