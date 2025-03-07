################################################################################
# For handling long path issues
################################################################################

if (dir.exists(".git")) {  # verify a Git repo
  system("git config --local core.longpaths true")
  system("git config --local include.path ../.gitconfig")
  message("✅ Git settings applied successfully!")
} else {
  message("❌ Not inside a Git repository. Run this script from a valid repo directory.")
}

# Check core.longpaths setting
longpaths <- system("git config --get core.longpaths", intern = TRUE)
cat("core.longpaths: ", longpaths, "\n")

# Check include.path setting
include_path <- system("git config --get include.path", intern = TRUE)
cat("include.path: ", include_path, "\n")
################################################################################
