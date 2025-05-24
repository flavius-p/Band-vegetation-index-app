# 🌿 Band Vegetation Index App

**Band Vegetation Index App** is a Shiny application developed to analyze raster data of vegetation indices. It allows for the reclassification of data into customizable classes, visualization of their distribution, and export of associated statistics. This tool is particularly useful in experimental or environmental monitoring contexts.

---

## 🚀 Main Features

- 📂 **Import multiple raster images**  
- 🧮 **Dynamic reclassification** into 5 to 20 classes depending on analysis needs  
- 📊 **Graphical visualization** of pixel percentages by class and by image  
- 🗺️ **Map display** of raw data projected onto a Google map (via `leaflet`/`mapview`)  
- 📤 **Export statistics** to Excel format for further analysis or archiving

---

## 🧰 Technologies Used

The application relies on the following R packages:

```r
required_packages <- c(
  "shinymanager", "here", "bslib", "dplyr", "shiny", "writexl",
  "leaflet", "raster", "readr", "ggplot2", "terra", "mapview",
  "stars", "gdalutils", "DBI", "RSQLite", "keyring"
)
```

## 🛠️Installation & Launch

1. ### **Clone or download** this repository.

2. ### Open the project in RStudio.

3. ### Run `app.R` or the folder containing the application.

```r
# Exemple
shiny::runApp("Bandvegetationindex")
```

## 👤 Author

**Flavien POTIAU**
 📧 flavien.potiau-enjouvin@hotmail.fr

## 📄 License

This project is open source under the terms of the **MIT License**.
