# reclassify_module function in reclassify_module.R
reclassify_module <- function(folder_path, class_limits, resopix) {
  # List all raster files in the specified folder
  raster_files <- list.files(folder_path, pattern = "\\.tif$", full.names = TRUE)
  
  # Initialize an empty data frame to store combined results
  combined_data <- data.frame()
  
  # Example debug output
  print("Raster Files:")
  print(raster_files)
  print("Class Limits:")
  print(class_limits)
  
  # Define the reclassification matrix based on user input
  # Initialize a matrix to hold the reclassification values
  reclass_matrix <- do.call(rbind, lapply(seq_along(class_limits), function(i) {
    c(class_limits[[i]][1], class_limits[[i]][2], i)  # Class i
  }))
  
  # Loop through each raster file
  for (raster_file in raster_files) {
    # Read the raster file
    r <- raster(raster_file)
    
    # Reclassify the raster using the reclassification matrix
    r_classified <- reclassify(r, reclass_matrix)
    
    # Get the classified pixel values and remove NAs
    values <- getValues(r_classified)
    values <- values[!is.na(values)]
    
    # Create a data frame for the classified values
    df <- data.frame(value = values)
    
    # Calculate pixel counts for each class
    pixel_data <- df %>%
      group_by(value) %>%
      summarize(pixel_count = n()) %>%
      mutate(Treatment = tools::file_path_sans_ext(basename(raster_file)))
    
    # Append the data to the combined data frame
    combined_data <- bind_rows(combined_data, pixel_data)
    
    print(paste("Processed:", raster_file))
  }
  
  # Calculate the total pixel count for each treatment
  combined_data <- combined_data %>%
    group_by(Treatment) %>%
    mutate(Total_Pixels = sum(pixel_count)) %>%
    ungroup()
  
  # Calculate the percentage of pixels for each class within its treatment
  combined_data <- combined_data %>%
    mutate(Percentage_Pixels = (pixel_count / Total_Pixels) * 100)
  
  return(combined_data)
}
