download_packages <- function(pkgs_to_download, typefiles) {
  # Download the needed packages into the pkg-source-files directory
  if (!is.null(pkgs_to_download)) {
    unlink("pkg-source-files/*")
    dir.create("pkg-source-files/", showWarnings = FALSE)

    dwnld_pkgs <-
      download.packages(
        pkgs = pkgs_to_download,
        destdir = "pkg-source-files",
        repos = repositories,
        type = typefiles
      )

    if (typefiles == 'source') {
      # If type = "source", generate a makefile to install the packages.
      # The makefile will stop if there is an error in any of the installs.
      # Using a bash script will not stop if there is an error.
      cat(
        "all:\n",
        paste0("\tR CMD INSTALL ", dwnld_pkgs[, 2], "\n"),
        sep = "",
        file = "makefile"
      )
    }
  }
}
