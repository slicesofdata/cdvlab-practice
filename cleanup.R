# this script is for cleaning up the repo and making it more lean.
# if "renv/library/" and "renv/staging/" are not in .gitignore,
# use this script to cleanup at termination of project

# run renv::snapshot() intermittently and when the project is completed run
renv::init()
renv::snapshot()


# When the project is completed, remove the libraries from the repo
# Files/directories to remove
to_remove <- c(
  ".RData",
  ".Rhistory",
  "renv/library/",
  "renv/staging/"
)

# Remove each item
purrr::walk(to_remove, function(x) {
  if (file.exists(x) || dir.exists(x)) {
    unlink(x, recursive = TRUE)
    message("Removed: ", x)
  }
})

message("Kept: renv.lock")
