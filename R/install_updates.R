install_updates <- function(typefiles) {
  old_packages <- old.packages()[, 1]
  set_repo_dir()
  if (!is.null(old_packages)) {
    download_packages(old_packages, typefiles)

    wkd <- paste(getwd(), "/pkg-source-files", sep = "")
    setwd(wkd)

    libs <- list.files() # Get a list of the downloaded packages
    for (p in libs) {
      install.packages(p, repos = NULL, type = typefiles)
    }
    setwd(startwd) # Return to starting directory
    rm(old_packages, repositories)
  }
}
