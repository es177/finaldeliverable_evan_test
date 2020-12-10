# Load libraries so they are available
library("shiny")
library("ggplot2")
library(lubridate)

nasa_modis_brightness <- read_csv("fire_archive_M6_169855.csv")

nasa_modis_brightness$acq_date <- as.Date(nasa_modis_brightness$acq_date)


# Define a server function
server <- function(input, output) {
  
  

# Interactive panel 2
  output$brightness_map <- renderLeaflet({
    
    prep_nasa_modis_brightness <- nasa_modis_brightness %>% 
      select(latitude, longitude, brightness, acq_date) %>% 
      filter(acq_date == input$acq_date) 
    
    palette_fn <- colorFactor(
      palette = "Dark2",
      domain = prep_nasa_modis_brightness[["acq_date"]]
    )
    
    leaflet(data = prep_nasa_modis_brightness) %>%
      addProviderTiles("Stamen.TonerLite") %>% 
      addCircleMarkers(
        lat = ~latitude,
        lng = ~longitude,
        label = ~paste0("The brightness is ", brightness, " fire pixels (Kelvin) on ", acq_date),
        color = ~palette_fn(prep_nasa_modis_brightness[["acq_date"]]),
        fillOpacity = .7,
        radius = 1,
        stroke = FALSE#,
        #color = "red"
      )
  })

 #output$map <- renderLeaflet({
  #return(build_map(joined_data, input$mapvar))
 #})
}

