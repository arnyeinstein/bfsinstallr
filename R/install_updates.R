#' Install updates from local repositories
#'
#' @param typefiles string either "source" (zip) or "binary" (tar.gz)
#'
#' @examples
#' install_updates("source")
install_updates <- function(typefiles) {
  old_packages <- utils::old.packages()[, 1]
  if (!is.null(old_packages)) {
    download_packages(old_packages, typefiles)
    startwd <- getwd()
    wkd <- paste(getwd(), "/pkg-source-files", sep = "")
    setwd(wkd)

    libs <- list.files() # Get a list of the downloaded packages
    for (p in libs) {
      utils::install.packages(p, repos = NULL, type = typefiles)
    }
    setwd(startwd) # Return to starting directory
    unlink("pkg-source-files", recursive = T)
  }
}
