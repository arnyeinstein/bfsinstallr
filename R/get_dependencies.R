get_dependencies <- function(pkgs_to_download, repositories) {
  # get a list of the available packages
  available_pkgs <- available.packages(repos = repositories)
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
    deps <- deps[!(deps %in% installed_pkgs)]
    pkgs_to_download <- append(pkgs_to_download, deps, i)
    i <- i + 1L
  }
  pkgs_to_download <- unique(rev(pkgs_to_download))
}
