# ui.R
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
  #"mapview",
  "stars",
  #"gdalutils",
  "DBI",
  "RSQLite",  # Added RSQLite for database connection,
  "keyring"
)

# Function to check if packages are installed
check_and_install <- function(pkg) {
  if (!require(pkg, character.only = TRUE)) {
    install.packages(pkg, dependencies = FALSE, repos = 'https://cloud.r-project.org')
    library(pkg, character.only = TRUE)
  }
}

# Loop over the required packages and install if missing
sapply(required_packages, check_and_install)

options(shiny.maxRequestSize = 30000 * 1024^2)

cards <- list(
  bslib::card(
    shiny::sliderInput("num_classes", "Nombres de Classes", min = 2, max = 20, value = 5),
    numericInput("resopix", "Résolution pixel (cm)", value = 2, min = 0.1, step = 0.1),
    uiOutput("class_limits_ui"),  # Dynamic UI for class limits
    uiOutput("progress")
  ),
  bslib::card(
    h4("Avancements"),
    textOutput("Progression"),
    h4("Résultats d'analyse"),
    conditionalPanel(
      condition = "output.dataAvailable == false",
      p("Pas de données disponibles, veuillez importer des données raster")
    ),
    conditionalPanel(
      condition = "output.dataAvailable == true",
      plotOutput("graph")
    )
  ),
  bslib::card(
    height = 200,
    fluidRow(
      column(
        width = 6,
        h2("Mode d'emploi de l'application"),
        h3("Présentation de l'outil"),
        p("Cette application permet la reclassification et l'analyse de données 
          raster à une bande (ex : indice de végétation). La finalité de cet 
          outils est de fournir de la données pré-traités pour 
          l'analyse d'indices raster monobande."),
        h3("Préparation des données"),
        p("Avant d'utiliser cette application, il est essentiel de préparer les 
          données. L'indice de végétation doit être calculé et/ou créé en dehors 
          de la plateforme, avec des outils comme WebODM ou la calculatrice raster
          de QGIS. Le plan d'essai doit être réalisé sous QGIS au format shape ou 
          équivalent. Ce plan sert à découper l'image raster en plusieurs tiles, 
          nommées par le nom des modalités. Il est possible de réaliser cette 
          tâche manuellement ou d'utiliser le plugin 'Easy Raster Splitter'."),
        p("Pour utiliser l'outil 'Easy Raster Splitter', accédez aux extensions 
          de QGIS, installer-le, puis sous l'onglet Raster, 
          sélectionnez 'Easy Raster Splitter'."),
        HTML('<center><img src="EasyRasterSplitter.png", 
             height = "600px", width = "800px"></center>'),
        p(""),
        p("Une fois les fichiers raster exportés dans un dossier, ils se chargent 
          dans la plateforme via le bouton 'Browse' dans la sidebar, puis en 
          confirmant avec le bouton 'upload data'. 
          Les boutons de pré-traitement des images et de visualisation 
          ('Launch Map') sont également disponibles. 
          Le pré-traitement permet la création de classes."),
        h3("Création des classes"),
        p("Le nombre de classes peut être choisi à l'aide du curseur sous l'onglet
          classification. Ce nombre peut être modifié à tout moment. 
          Après avoir déterminé et délimité les classes, le pré-traitement 
          peut être lancé. Une fois le pré-traitement terminé, les images 
          chargées peuvent être vérifiées sous l'onglet 'Visualisation'. 
          il est possible de lancer le traitement des données pour obtenir 
          des graphiques de répartition par classes choisies sous 
          l'onglet 'Résultats'."),
        h4("Graphiques et export des données"),
        p("Les données créées et les graphiques peuvent être récupérés. 
          Un bouton 'Télécharger les données' est disponible dans la sidebar. 
          Pour enregistrer le graphique, effectuez un clic droit et 
          sélectionnez 'enregistrer sous...'."),
        tags$ul(
          tags$li("Utilisez les boutons pour ajuster les couches et les visualisations."),
          tags$li("Cliquez sur la carte pour obtenir des informations supplémentaires."),
          tags$li("Vous pouvez zoomer et dézoomer à l'aide des contrôles sur la carte.")
        ),
        p("Pour toute question supplémentaire, veuillez consulter...A compléter + Images"),
        #HTML('<center><img src="LIA.png", height = "600px", width = "800px"></center>'),
      )
    )
  ),
  bslib::card(
    plotOutput("rasters_plotting"),
    leafletOutput("leafletmap")
  )
)

# Define UI
ui <- 
  fluidPage(
    tags$h2("Welcome!"),
    verbatimTextOutput("auth_status"),
    verbatimTextOutput("status"),
    page_sidebar(
      theme = bs_theme(version = 5),
      fluidPage(
        tags$head(
        )
      ),
      title = "Reclassification et Analyse de données raster à une bande",
      sidebar = sidebar(
        title = "Data Input",
        h6("Dépôt d'images rasters"),
        fileInput("data_files", "*.tif", accept = c(".tif"), multiple = TRUE),
        actionButton("upload_button", 'upload data'),
        textOutput("upload_status"),
        uiOutput("preprocessing"),
        uiOutput("ActiveMap"),
        textOutput("status"),
        uiOutput("processing"),
        uiOutput("downloadoption"),
        actionButton("reset_button", "Reset App"),
        actionButton("quit_button", "Quit App")
      ),
      navset_card_underline(
        title = "Analyse",
        nav_panel("Classification", cards[[1]]),
        nav_panel("Résultats", cards[[2]]),
        nav_panel("Visualisation", cards[[4]]),
        nav_panel("Mode d'emploi", cards[[3]])
      )
    )
  )
ui <- secure_app(ui, enable_admin = TRUE)
