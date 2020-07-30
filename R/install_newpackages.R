#' Install list of packages from local directory
#'
#' @param listtoinstall List of packages to install
#' @param typefiles string either source (zip) or binary (tar.gz)
#'
#' @examples
#' install_newpackages(c("ggplot2", "dplyr"), "source")
install_newpackages <- function(listtoinstall, typefiles) {

  startwd <- getwd()
  pkgs_installed <- utils::installed.packages()[,1]
  listtoinstall <- listtoinstall[!listtoinstall %in% pkgs_installed]
  pkgs_to_download <- get_dependencies(listtoinstall)
  download_packages(pkgs_to_download, typefiles)

  wkd <- paste(getwd(), "/pkg-source-files", sep = "")
  setwd(wkd)

  libs <- list.files() # Get a list of the downloaded packages
  for (p in libs) {
    utils::install.packages(p, repos = NULL, type = typefiles)
  }
  setwd(startwd) # Return to starting directory
  unlink("pkg-source-files", recursive = T)
}
