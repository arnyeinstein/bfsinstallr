install_newpackages <- function(listtoinstall, typefiles) {

  set_repo_dir()

  installed_pkgs <<- installed.packages()[,1]
  listtoinstall <- listtoinstall[!listtoinstall %in% installed_pkgs]
  pkgs_to_download <- get_dependencies(listtoinstall, repositories)
  download_packages(pkgs_to_download, typefiles)

  wkd <- paste(getwd(), "/pkg-source-files", sep = "")
  setwd(wkd)

  libs <- list.files() # Get a list of the downloaded packages
  for (p in libs) {
    install.packages(p, repos = NULL, type = typefiles)
  }
  setwd(startwd) # Return to starting directory
  rm(installedpackages, repositories)
}
