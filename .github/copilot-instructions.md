# GitHub Copilot Instructions

## General Guidelines
- Every time you need to fix linter errors and provide the error messages, update the Linter section in .github/copilot-instructions.md accordingly. Use concise, oneliner instruction. Ensure your future responses avoid repeating the same errors.
- Always use the native pipe operator `|>` instead of the magrittr pipe `%>%` in all R code.
- Use NZ (New Zealand) English spelling for all function names and documentation (e.g., "colour" not "color").
- Name files in `R/` with hyphenated prefixes to signal logical layers (e.g., `domain-value_objects.R`) because subdirectories are not permitted.
- Assume all the required packages are declared in `DESCRIPTION` and installed in the environment; Never not use runtime checks like `if (requireNamespace("pkgname"))` in package scripts.

---

## Shiny Application Design and Development

- When designing a Shiny web app part, use the context7 tool first to plan the work.
- Search context7 for "golem" to understand how to structure the files so the web app behaves like a package.
- Use context7 for the "shiny" package when you need reference on basic Shiny components.
- Consult context7 for "shinydashboard" when working with dashboard-specific layout parts.
- Consult context7 for "shinydashboardPlus" when handling controlbar or other dashboard-plus specific components.
- Refer to context7 for "mastering-shiny" for guidance on Shiny mechanics, best practices, and reactivity patterns.

---

## Architecture and Design Principles

- We use a layered architecture approach, separating concerns into distinct layers (e.g., domain, functions, application) to enhance maintainability and testability.
- Each layer should only depend on layers below it, promoting loose coupling and high cohesion.
- Functions that belong to different layers, live in different files. We name our files in `R/` starting with the layer name, and then hyphenated for the module.

The layers are as such:
- app | mod
- functions
- domain

For functions that receive and/or return `data.frame` we strive to use value objects to our instead of generic data.frames

## Linter
- Markdown: avoid tab characters and keep blank lines before/after fenced code blocks.
- Markdown: start files with a top-level heading.
- Markdown: surround lists with blank lines.
- Markdown: ensure fenced code blocks are balanced (no stray closing ```); remove unmatched fences.
- R: replace non-ASCII characters in R source code with ASCII equivalents (e.g., em dash `—` → hyphen `-`). Non-ASCII characters in data/config (YAML, comments) are acceptable.
 - R: avoid raw non-ASCII symbols in R/ source (e.g., µ, superscripts). Use plotmath in code (e.g. `expression(mu)` or `annotate(..., label = "mu == 10", parse = TRUE)`) and use `\eqn{\mu}` (with an ASCII fallback) in roxygen/Rd. Non-ASCII in data/config (YAML, comments) is acceptable.
- R: avoid `@importFrom` for functions that conflict with base R (e.g., `config::get()`, `base::get()`); use namespace notation instead.
- R: in plotmath unit expressions use `*` instead of `~` for tight prefix spacing (e.g., `mu*g/cm^2`).
- R: in roxygen2 `@param` and roxygen comments, escape curly braces as `\{` and `\}` (e.g., `\{shiny\}` not `{shiny}`) to prevent Rd formatting errors.
- R: use `.data$column_name` instead of bare column names in `dplyr` verbs to avoid R CMD check global variable binding warnings (e.g., `dplyr::filter(.data$id == "value")`).

---

## Documentation

### Function Documentation with Child Vignettes

- **Extract detailed methodology to child vignettes**: For functions with complex formulas, algorithms, or methodology details, create a separate `.Rmd` file in `vignettes/functions/` subdirectory (e.g., `vignettes/functions/methodology-details.Rmd`). Keep only brief descriptions, `@param`, `@return`, and `@examples` in the function's roxygen2 comments.

- **Reference child vignettes in roxygen2**: In the function's `@details` section, include the child vignette using `@details \n```{r child = "vignettes/functions/<name>.Rmd"}\n````. When you run `devtools::document()`, the child content will be automatically rendered into the `.Rd` help file, maintaining a single source of truth.

- **Reuse across functions**: Use shared child vignettes (e.g., `vignettes/functions/methodology-details.Rmd`) for methodology that applies to multiple functions. This enforces DRY principles and ensures consistency—update once, reflected everywhere.

- **Organize function vignettes**: All child vignettes referenced in function documentation should be stored in `vignettes/functions/` subdirectory. Add the pattern `^vignettes/functions/` to `.Rbuildignore` to prevent these files from being detected as standalone vignettes.

- **Use .Rd-compatible math notation**: Raw LaTeX (`$$`, `\times`, `\frac`) doesn't work in roxygen2. Use `\deqn{}` for display equations, `\eqn{}` for inline math, `\cdot` for multiplication, `/` for division, and `_{subscript}` for subscripts.

- **Use `\eqn{}` with ASCII fallbacks for symbols in roxygen2**: Instead of raw Unicode characters or plain text, use Rd's math wrappers with ASCII fallbacks in `@param`, `@return`, and other roxygen2 sections:
  - **Syntax**: `\eqn{latex}{ascii}` renders LaTeX in PDF/HTML and uses ASCII text in plain-text help
  - **Note**: Avoid raw Unicode characters (μ, °) or Unicode escapes (`\u03bc`) in roxygen comments—they cause build failures

- **Wrap examples in `\dontrun{}`**: Always wrap function examples in `@examples` sections with `\dontrun{}` to prevent them from being executed during `R CMD check`, unless they are simple, fast, and have no external dependencies.

---

## Plotting Guidelines

- **Use ggplot2 for all plots**: All visualizations should be created using the ggplot2 package to ensure consistency and leverage its powerful layering system.

- **Use the `scales` package for axis formatting**: For formatting axis labels and breaks, always use functions from the `scales` package (e.g., `scales::label_number()`, `scales::breaks_extended()`) to ensure consistent and professional appearance.

---

## Shiny Module & Configuration Best Practices

- **Externalize configuration to YAML**: Store slider parameters, UI configuration, and other settings in `inst/config/` as YAML files instead of hardcoding in R. Use `config::get()` to load at package initialization.

- **Use `purrr::map_dfr()` for robust config conversion**: When converting lists from config files to tibbles, prefer `purrr::map_dfr(cfg, tibble::as_tibble)` over `do.call(rbind, lapply(...))` for better type preservation and error handling.

- **Avoid row iteration with `seq_len(nrow())`**: When iterating over data frame/tibble rows, use `purrr::pmap()` instead of `lapply(seq_len(nrow(...)), ...)` for better performance and readability.

- **Validate config early**: Add error handling when loading external configuration to fail fast if config is empty, malformed, or missing required fields.

---

## Data Wrangling

- Prefer `dplyr` (tidyverse) verbs for data manipulation for clearer intent, consistent semantics with tibbles, and better compatibility with grouped operations.

- Prefer `dplyr` alternatives to base functions. For example:
  
  - use `dplyr::group_split()` rather than `base::split()`
  - use `dplyr::bind_rows()` rather than `base::rbind()`
  - use `dplyr::filter(.data$col == value)` rather than `base::subset()` or manual indexing

- Avoid concatenating multiple columns into a single string to encode structured information, and avoid ad-hoc parsing of strings to reconstruct columns. Keep distinct data elements in separate columns (or use list-columns) so types and semantics are preserved.

- When splitting, binding, or combining data, prefer the `dplyr`/tidyverse approach to preserve column types and attributes and to avoid unexpected behaviour with tibbles.

---

## Defensive checks guideline

- Never add defensive checks (for example, input validation, `stop()` on missing columns, or NULL guards) inside function bodies unless explicitly instructed to do so.
- Do not add `warning()` calls inside functions unless explicitly instructed to do so.
- Assume validated value objects provide required columns and types; do not re-check inputs inside functions that use value-objects.