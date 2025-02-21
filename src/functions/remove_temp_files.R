###############################################################
## Function to remove all _.txt files after cloning repo
###############################################################
remove_temp_files <- function(dir, file = "_.txt") {
  # Get a list of all files and full path
  files = list.files(recursive = TRUE, pattern = file, full.names = TRUE)

  # remove or message
  if (length(files) > 0) { lapply(files, file.remove) } else {
    message("No files to delete.")
  }
}

#remove_temp_files()

###############################################################
## Function to create _.txt files in each dir recursively
###############################################################
create_temp_files <- function(file = "_.txt") {
  # Get a list of all directories within the root directory, including the root directory
  #dir_list <- ''
  list.dirs(recursive = TRUE, full.names = TRUE) |>
    lapply(FUN = function(x) file.create(file.path(x, file), showWarnings = FALSE))
}

#create_temp_files()

