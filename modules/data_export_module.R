# data_export_module.R
library(writexl)

# Function to export data as .xlsx
export_data <- function(data, filename) {
  write.csv2(data, filename)
  return(paste("Data exported successfully to", filename))
}