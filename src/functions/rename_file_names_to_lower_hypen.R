################################################################
# Script Name: rename_filenames.R
# Author: slicesofdata
# GitHub: slicesofdata
# Date Created: 01/09/2025
#
# Purpose: This script is to rename files to make uniform,
# specifically to make file names lowercase
#
################################################################

################################################################
# Note: When sourcing script files, if you do not want objects
# available in this script, use the source() function along with
# the local = TRUE argument. By default, source() will make
# objects available in the current environment.

################################################################
# Load necessary libraries/source any function directories
# Example:
R.utils::sourceDirectory(here::here("src", "functions"))


################################################################
# ...

rename_files <- function(directory,
                         spaces_to = "-",
                         recursive = TRUE
                         ) {
  # Load necessary library
  pacman::p_load(fs)

  # Get all files in the directory recursively
  all_files <- fs::dir_ls(directory, recurse = recursive, type = "file")

  # Iterate over each file
  for (file in all_files) {
    # Get the directory and filename parts
    file_dir <- fs::path_dir(file)
    file_name <- fs::path_file(file)

    # Convert to lowercase and replace spaces with hyphens
    new_name <- gsub(" ", "-", tolower(file_name))

    # Construct the new file path
    new_file_path <- fs::path(file_dir, new_name)

    # Rename the file if the name has changed
    if (file != new_file_path) {
      fs::file_move(file, new_file_path)
    }
  }

  message("File renaming complete.")
}

################################################################
# ...


################################################################
# ...

################################################################
# End of script
