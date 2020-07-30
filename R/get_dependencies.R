#' Get dependencies for package list to be installed
#'
#' Function necessary for the \code{install_updates} and
#'   \code{install_newpackages} function. It finds the dependencies for those
#'   packages that are to be updated or installed.
#'
#' @param pkgs_to_download list with packages
#'
#' @examples
#' get_dependencies(c("ggplot2", "dplyr"))

get_dependencies <- function(pkgs_to_download) {
  # get a list of the available packages
  repositories <- bfsinstallr::set_repo_dir()
  pkgs_installed <- utils::installed.packages()[,1]
  available_pkgs <- utils::available.packages(repos = repositories)
  # use the tools::package_dependencies function to generate a list of the
  # packages dependencies, and dependencies of dependencies, and so on, ...
  i <- 1L
  while (i <= length(pkgs_to_download)) {
    deps <-
      unlist(
        tools::package_dependencies(
          packages = pkgs_to_download[i],
          which = c("Depends", "Imports", "LinkingTo"),
          db = available_pkgs,
          recursive = FALSE
        ),
        use.names = FALSE
      )
    deps <- deps[!(deps %in% pkgs_installed)]
    pkgs_to_download <- append(pkgs_to_download, deps, i)
    i <- i + 1L
  }
  pkgs_to_download <- unique(rev(pkgs_to_download))
}
