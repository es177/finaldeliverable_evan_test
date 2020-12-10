library(shiny)
library(ggplot2)
library(dplyr)
library(leaflet)
library(mapview)
## Work on respective portions here

## Christian, Milli
intro_panel <- tabPanel(
  titlePanel("Practice")
)

## Evan


interactive_panel_2 <- tabPanel(
  titlePanel("Fire Brightness/Intensity"),
  h2("Taken from NASA's MODIS Satellite"),
  
  sidebarPanel(
    titlePanel("Specify your brightness map data"),
    sliderInput(inputId = "acq_date",
                label = "Peak Dates: June 2019 - May 2020",
                min = as.Date("2019-06-01","%Y-%m-%d"),
                max = as.Date("2020-05-31","%Y-%m-%d"),
                value=as.Date("2020-05-31"),
                timeFormat="%Y-%m-%d"),
    checkboxGroupInput(inputId = "daynight", 
                       label = "Check day (D)/night (N) or both",
                       choices = list("D", "N"), 
                       selected = list("D", "N"))
      ),
  mainPanel(
      leafletOutput(outputId = "brightness_map")
      ),
  h4("Map Findings"),
  p("By looking at the dates over time we were able to analyze how the fire spread and jumped 
      from city to city and through many of the vast grasslands and open spaces Australia has. There was also a 
      constant pressure on the Northern and South Eastern Portions of Australia with a Wildfire persisting through every day of the explored time period."),
  h4("About the MODIS Satellite"),
  p("The MODIS or (Moderate Resolution Imaging Spectroradiometer) features a low spatial resolution but high temporal resolution, MODIS data are useful to track changes in the landscape over time. 
    Examples of such applications are the monitoring of vegetation health by means of time-series analyses with vegetation indices, long term land
    cover changes (e.g. to monitor deforestation rates), global snow cover trends, water inundation from pluvial, riverine, or sea 
    level rise flooding in coastal areas, change of water levels of major lakes such as the Aral Sea, and the detection and mapping of wildland fires in the United States and around the world bringing our application of Australia. 
    Centre's like the 'The United States Forest Service's Remote Sensing Applications Center' analyzes MODIS imagery on a continuous basis to provide information for the management and suppression of wildfires"),
  img(src = "modis_scan.jpg")
  )


## Final UI
ui <- navbarPage(
  # A page header with a descriptive title
  "Australia",
  
  intro_panel, 
  
  interactive_panel_2
  )
