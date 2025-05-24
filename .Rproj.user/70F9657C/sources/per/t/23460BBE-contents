# debug

# Required packages
required_packages <- c(
  "shinymanager",
  "here",
  "bslib",
  "dplyr",
  "shiny",
  "writexl",
  "leaflet",
  "raster",
  "readr",
  "ggplot2",
  "terra",
  "mapview",
  "stars",
  "gdalutils",
  "DBI",
  "RSQLite",  # Added RSQLite for database connection,
  "keyring"
)

# Function to check if packages are installed
check_and_install <- function(pkg) {
  if (!require(pkg, character.only = TRUE)) {
    install.packages(pkg, dependencies = TRUE, repos = 'https://cloud.r-project.org')
    library(pkg, character.only = TRUE)
  }
}

# Loop over the required packages and install if missing
sapply(required_packages, check_and_install)

options(shiny.maxRequestSize = 30000 * 1024^2)

# Get the executing folder
main_script_dir <- here()
print(here())

# Define the path to the modules folder
modules_path <- "modules"

# Load modules from the "modules" folder
source(file.path(main_script_dir, "ui.R"))
source(file.path(main_script_dir, "server.R"))

# Function to read credentials from the database
get_credentials <- function(db_path) {
  conn <- dbConnect(RSQLite::SQLite(), dbname = db_path)
  credentials <- dbGetQuery(conn, "SELECT user, password FROM users")
  dbDisconnect(conn)
  return(credentials)
}

# Define the path to the database
main_dir <- here()
db_path <- file.path(main_dir, "harddata", "database.sqlite")
print(db_path)

# Create the initial leaflet map object
map <- leaflet()


# Run the application 
shinyApp(ui = ui, server = server)
