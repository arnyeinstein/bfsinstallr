#' Set repositories to look for packages
#'
#' @return character vector of repositories
#' @examples
#' repositories <- set_repo_dir()

set_repo_dir <- function () {
  CRAN <- "https://cran.rstudio.com/"
  BIOC <- "https://bioconductor.org/packages/release/bioc/"
  c(CRAN, BIOC)
  }
