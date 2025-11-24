# Set CRAN repository to Posit snapshot matching the R release date
# This ensures reproducible package installation across different environments
local({
  version_info <- R.Version()
  release_date <- sprintf(
    "%s-%02i-%02i",
    version_info$year,
    as.integer(version_info$month),
    as.integer(version_info$day)
  )
  repos <- sprintf("https://packagemanager.posit.co/cran/%s", release_date)
  options(repos = repos)
})
