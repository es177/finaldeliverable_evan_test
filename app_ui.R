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
  sidebarPanel(
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
      )
  )


## Final UI
ui <- navbarPage(
  # A page header with a descriptive title
  "Australia",
  
  intro_panel, 
  
  interactive_panel_2
  )
