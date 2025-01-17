# State WSB downloader helper functions  -----------------------------------

# suppress warning: package ‘fs’ was built under R version ...
suppressWarnings(suppressMessages(library(fs)))

# path to save raw data
data_path <- Sys.getenv("WSB_DATA_PATH")

# function to download url
# file_ext argument is optional; if not provided, generated from url ending
download_wsb <- function(url, state, file_ext) {

  cat("Starting download for", toupper(state), "boundary data...\n\n")
  
  # create outputted file directory
  dir_path <- path(data_path, paste0("boundary/", state))
  dir_create(dir_path)
  
  # get file extension to create outputted file name and path
  if (missing(file_ext)) {
    file_ext  <- sub(".*\\.", "", url)
  }
  file_name <- paste0(state, ".", file_ext)
  file_path <- path(dir_path, file_name)
  
  # download url
  download.file(url, file_path)
  
  # unzip if the downloaded file has a zip extension
  if (file_ext == "zip") {
    unzip_wsb(file_path, dir_path, state) 
  } else {
    cat("Downloaded", toupper(state), "boundary data.\n\n\n")
  }
}

# function to unzip file
unzip_wsb <- function(file_path, dir_path, state) {
  # unzip file
  unzip(zipfile = file_path, exdir = dir_path)
  cat("Downloaded and unzipped", toupper(state), "boundary data.\n\n\n")
}
