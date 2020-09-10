#' Install updates from local repositories
#'
#' @param typefiles string either "source" (tar.gz) or "binary" (zip)
#' @param packlist list with packages to be updated
#'
#' @examples
#' # install_updates("ggplot2", "source")

install_updates <- function(packlist, typefiles = "source") {
  names(packlist) <- packlist
  startdir <- getwd()
  uwkd <- c("C:/")
  setwd(uwkd)
  wkd <- paste(uwkd, "pkg-source-files", sep = "")
  old_packages <- utils::old.packages(repos =  set_repo_dir())[, 1]

  # Check if the package is an old installed package
  updates_available <- 0
  for (p in packlist) {
    if (!is.null(old_packages) &  p %in% old_packages) {
      download_packages(p, typefiles)
      updates_available <- updates_available + 1
    }
  }
  if (updates_available > 0) {
    setwd(wkd)
    remove.packages(packlist)
    libs <- list.files()
    for (p in packlist) {
      utils::install.packages(libs[p], repos = NULL, type = typefiles)
      #        print(paste("Package ", p, " up to date or not installed (then, please install)."))
    }
    setwd(uwkd)
    unlink("pkg-source-files", recursive = T)
  }
  on.exit(setwd(startdir)) # Return to starting directory
}
