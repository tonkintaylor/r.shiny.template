# Data Wrangling

- Prefer using packages from the "tidyverse" collection for data manipulation tasks. This includes using "dplyr" for data frame operations, "tibble" for enhanced data frames, and "readr" for reading data files.
- Prefer using "purrr" for functional programming tasks, such as mapping functions over lists or vectors.

## Namespace Management

- **Prefer `@importFrom` over `@import`**: Always use `@importFrom package_name specific_functions` rather than `@import package_name` for all packages. This keeps the namespace clean and makes dependencies explicit by only importing the functions actually used in the codebase.
- **Centralize imports in `<pkg-name>-package.R`**: Declare all `@importFrom` statements in `R/<pkg-name>-package.R` instead of in individual function roxygen comments. This provides a single source of truth for all package dependencies.
- **Exception**: Only use `@import` in rare cases where a package is used extensively throughout the codebase (e.g., `rlang` for error handling utilities across many functions).

## Shiny App

- We are using the "golem" framework for building the Shiny application. Use the context7 mcp tool to get more context on how to use golem functions and structure your app.
- **Colour customization**: Update colour constants in `R/app-themes-constants.R` and use `create_app_theme()` in `R/app-themes.R` to apply them to the dashboard.
- **Theme customization via `app-themes.R`**: All dashboard theme customization (colors, layouts, backgrounds) should be done through the `create_app_theme()` function in `R/app-themes.R`. Before adding custom CSS or other styling methods, check `app-themes.R` first—it likely already provides a way to control the element you want to change. The function uses the `fresh` package to manage:
  - Box header colors (via `adminlte_color()`)
  - Dashboard backgrounds and box backgrounds (via `adminlte_global()`)
  - Sidebar styling (via `adminlte_sidebar()`)
  - Other AdminLTE theme variables
  - See `R/app-themes.R` for current theme configuration and available customization options.
- **Using `fresh` themes in Shiny**: Call `use_theme(create_app_theme())` directly inside `dashboardBody()`, not in `tagList()`. The theme function must be invoked where it's applied (inside the body element), not stored as a variable in the tagList wrapper.

- **Icons for UI elements**: Always use `icon()` (from Shiny/Font Awesome) instead of emoji symbols or special Unicode characters to avoid non-ASCII characters in R code. Examples: Use `icon("info-circle")` instead of "ℹ️"

- **Controlbar widget width**: When adding widgets to the controlbar, always set `width = "100%"` for widgets that provide a width argument so they align with the panel.
