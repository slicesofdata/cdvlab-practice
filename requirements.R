# restoring the project lock file or viewing libraries


# install
install.packages("pacman")
install.packages("renv")

# restore the renv.lock file to activate libraries and versions
renv::restore()
# renv.lock is created by renv::snapshot() and is part of cleanup


# To read the libraries in the lock file without restoring the lock file:
pacman::p_load(jsonlite)
lock_data <- jsonlite::fromJSON("renv.lock")


package_list <- list(); for (pkg_name in names(lock_data$Packages)) {
  pkg_data <- lock_data$Packages[[pkg_name]]
  package_list[[pkg_name]] <- data.frame(
    Package = pkg_name,
    Version = pkg_data$Version,
    Source = pkg_data$Source,
    Repository = pkg_data$Repository
  )
}

result <- do.call(rbind, package_list)

# view the libraries and versions
View(result)

# if a file is needed for viewing libraries, save one
print_libraries = FALSE

if (print_libraries) {
  write.table(x = result,
              file = here::here("libraries.txt"),
              sep = "\t",
              )
}
