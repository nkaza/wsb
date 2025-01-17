# Download TX water system data -------------------------------------------

library(fs)

# path to save raw data
data_path <- Sys.getenv("WSB_DATA_PATH")

# Allow for longer timeout to map download file
options(timeout = 10000)

# Data Source: Texas ArcGIS geojson water system boundary
url <- paste0("https://github.com/NIEPS-Water-Program/",
                 "water-affordability/raw/main/data/tx_systems.geojson")

# create dir to store file and download
dir_create(path(data_path, "boundary/tx"))
download.file(url, path(data_path, "boundary/tx/tx.geojson"))
cat("Downloaded TX polygon boundary data.\n")
