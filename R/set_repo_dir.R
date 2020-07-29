# Repositories to look for packages
set_repo_dir <- function () {
  CRAN <- "https://cran.rstudio.com/"
  BIOC <- "https://bioconductor.org/packages/release/bioc/"
  repositories <<- c(CRAN, BIOC)

  startwd <-
    getwd()  # Save actuall directory and remove old packages directory
  if (dir.exists("../pkg-source-files")) {
    unlink("../pkg-source-files", recursive = TRUE)
  }
}
