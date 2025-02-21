#############################################################################
# specify the directories
directories <- c(
  "_ignore_this_dir",
  "data",
  "data/raw",
  "data/interim",
  "data/processed",
  "docs",
  "report",
  "report/figs",
  "report/images",
  "refs",
  "src",
  "src/data",
  "src/figs",
  "src/r",
  "src/utils"
)

# Define the files to be created
files <- list(
  "README.md" = "# Project Title\n\nProject Description",
  "requirements.txt" = "# List of libraries and dependencies\n"
)

# Function to create directories
create_directories <- function(dirs) {
  for (dir in dirs) {
    dir_path <- here::here(dir)
    if (!dir.exists(dir_path)) {
      dir.create(dir_path, recursive = TRUE)
      cat(paste("Created directory:", dir_path, "\n"))
    } else {
      cat(paste("Directory already exists:", dir_path, "\n"))
    }
  }
}

# Function to create files
create_files <- function(files) {
  for (file in names(files)) {
    file_path <- here::here(file)
    if (!file.exists(file_path)) {
      writeLines(files[[file]], file_path)
      cat(paste("Created file:", file_path, "\n"))
    } else {
      cat(paste("File already exists:", file_path, "\n"))
    }
  }
}

# Create the directories
create_directories(directories)

# Create the files
create_files(files)

# Update .gitignore file
# # Define the content you want in the .gitignore file
gitignore_content <- "

##############################################################################
## R and RStudio files ##
# Ignore R data files
*.RData
*.Ruserdata
*.rdb
*.rdx
Rplots.pdf
*.Rout
*_Rout.txt

# Ignore R history files
.Rhistory
.Rapp.history
.Rprofile

# Ignore the RStudio project files
.Rproj.user/
.Rproj

# Ignore the RStudio folders
.Rproj.user/
.Rproj.user/*
##############################################################################

##############################################################################
## complete directories to ignore ##
_ignore_this_dir
##############################################################################

## image/pdf files ##
#*.pdf
#*.png # will want for report files and for client slidedecks
*.tiff
#*.jpg
#*.jpeg

##############################################################################
## macOS DS_Store files ##
.DS_Store
.DS_Store?

##############################################################################

##############################################################################
## Packages/zip/iso files ##
## it's better to unpack these files and commit the raw source
## git has its own built in compression methods
*.7z
*.dmg
*.gz
*.iso
*.jar
*.rar
*.tar
*.zip
##############################################################################

##############################################################################
## Database related ##
*.sql
*.sqlite
##############################################################################

##############################################################################
## latex ##
*.aux
*.glo
*.idx
*.log
*.toc
*.ist
*.acn
*.acr
*.alg
*.bbl
*.blg
*.dvi
*.glg
*.gls
*.ilg
*.ind
*.lof
*.lot
*.maf
*.mtc
*.mtc1
*.out
*.synctex.gz
*.pdfsync
*.nav
*.snm

##############################################################################
## latexmk ##
*.fdb_latexmk
*.fls
##############################################################################

##############################################################################
## C object files ##
*.o
*.so

##############################################################################
"

# Write the content to the .gitignore file
writeLines(gitignore_content, ".gitignore")

# Print a confirmation message
cat("The .gitignore file has been created and written to successfully.\n")
