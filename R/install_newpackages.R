#' Install list of packages from local directory
#'
#' @param listtoinstall List of packages to install
#' @param typefiles string either source (tar.gz) or binary (zip)
#'
#' @example

install_newpackages <- function(listtoinstall, typefiles = "source") {
  startdir <- getwd()
  names(listtoinstall) <- listtoinstall
  uwkd <- c("C:/")
  ukwd <- Sys.getenv('HOME')
  setwd(uwkd)
  pkgs_installed <- utils::installed.packages()[,1]
  listtoremove <- listtoinstall[listtoinstall %in% pkgs_installed]
  remove.packages(listtoremove)
  # listtoinstall <- listtoinstall[!listtoinstall %in% pkgs_installed]
  pkgs_to_download <- get_dependencies(listtoinstall)
  download_packages(pkgs_to_download, typefiles)
  wkd <- paste(uwkd, "/pkg-source-files", sep = "")
  setwd(wkd)
  libs <- list.files() # Get a list of the downloaded packages
  for (p in libs) {
    utils::install.packages(p, repos = NULL, type = typefiles)
  }
  setwd(uwkd)
  unlink("pkg-source-files", recursive = T)
  on.exit(setwd(startdir)) # Return to starting directory
}

is.installed <- function(mypkg){
  is.element(mypkg, installed.packages()[,1])
}

if(any(grepl("package:ggplot2", search()))) detach("package:ggplot2") else message("ggplot2 not loaded")
## plyr not loaded
