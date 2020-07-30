#' Download packages locally
#'
#' @param pkgs_to_download character list with packages to download
#' @param typefiles string indicating what type to download (source or binary)
#'
#' @return the directory ./pgk_source_files is created if it does not exists and
#'   all the files are downloaded to this directory.
#'
#' @examples
#' download_packages("ggplot2","source")
download_packages <- function(pkgs_to_download, typefiles) {
  # Download the needed packages into the pkg-source-files directory
  if (!is.null(pkgs_to_download)) {
    unlink("pkg-source-files", recursive = T)
    dir.create("pkg-source-files/", showWarnings = FALSE)
    repositories <- set_repo_dir()
    dwnld_pkgs <-
      utils::download.packages(
        pkgs = pkgs_to_download,
        destdir = "pkg-source-files",
        repos = repositories,
        type = typefiles
      )
  }
}
