################################################################
# Script Name: create_smaple_data.R
# GitHub: slicesofdata
# Date Created: 9/9/2024
#
# Purpose: To create sample data files
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
# Create .csv and .Rds versions of mtcars

data("mtcars") |>
  write.csv(file = here::here("data", "raw", "mtcars.csv"),
            row.names = FALSE
            )


data("mtcars") |>
  saveRDS(file = here::here("data", "raw", "mtcars.Rds"))


################################################################
# End of script
