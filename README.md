# 🌿 Band Vegetation Index App

**Band Vegetation Index App** est une application Shiny développée pour analyser des données raster d’indices de végétation. Elle permet de reclassifier les données selon des classes personnalisables, d’en visualiser la répartition et d’exporter les statistiques associées. Cet outil est particulièrement utile dans un contexte expérimental ou de suivi environnemental.

---

## 🚀 Fonctionnalités principales

- 📂 **Import de plusieurs images raster**  
- 🧮 **Reclassification dynamique** en 5 à 20 classes selon les besoins de l’analyse  
- 📊 **Visualisation graphique** du pourcentage de pixels par classe et par image  
- 🗺️ **Affichage cartographique** des données brutes projetées sur une carte Google (via `leaflet`/`mapview`)  
- 📤 **Export des statistiques** au format Excel pour analyse ou archivage

---

## 🧰 Technologies utilisées

L’application repose sur les packages suivants :

```r
required_packages <- c(
  "shinymanager", "here", "bslib", "dplyr", "shiny", "writexl",
  "leaflet", "raster", "readr", "ggplot2", "terra", "mapview",
  "stars", "gdalutils", "DBI", "RSQLite", "keyring"
)
```

## 🛠️Installation & Lancement

1. ### **Cloner ou télécharger** ce dépôt.

2. ### Ouvrir le projet dans RStudio.

3. ### Exécuter `app.R` ou le dossier contenant l’application.

```r
# Exemple
shiny::runApp("Bandvegetationindex")
```

## 👤 Auteur

**Flavien POTIAU**
 📧 flavien.potiau-enjouvin@hotmail.fr

## 📄 Licence

Ce projet est libre de droits selon les termes de la **licence MIT**.