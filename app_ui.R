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
nasa_modis_brightness <- read_csv("fire_archive_M6_169855.csv")

prep_nasa_modis_brightness <- nasa_modis_brightness %>% 
  select(latitude, longitude, brightness, acq_date) %>% 
  mutate(acq_date = as.Date(acq_date))

interactive_panel_2 <- tabPanel(
  titlePanel("Fire Brightness/Intensity"),
  sidebarPanel(
    sliderInput(inputId = "acq_date",
                label = "Peak Dates: June 2019 - May 2020",
                min = as.Date("2019-06-01","%Y-%m-%d"),
                max = as.Date("2020-05-31","%Y-%m-%d"),
                value=as.Date("2020-05-31"),
                timeFormat="%Y-%m-%d")
      ),
    mainPanel(
      leafletOutput(outputId = "brightness_map")
      )
  )


## Final UI
ui <- navbarPage(
  # A page header with a descriptive title
  "Australia",
  
  intro_panel, 
  
  interactive_panel_2
  )
