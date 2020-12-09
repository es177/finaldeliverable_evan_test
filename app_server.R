# Load libraries so they are available
library("shiny")
library("ggplot2")


# Define a server function
server <- function(input, output) {

# Interactive panel 2
  output$brightness_map <- renderLeaflet({
    
    palette_fn <- colorFactor(
      palette = "Dark2",
      domain = prep_nasa_modis_brightness[[acq_date == input$acq_date]]
    )
    
    leaflet(data = prep_nasa_modis_brightness) %>%
      addProviderTiles("Stamen.TonerLite") %>% 
      addCircleMarkers(
        lat = ~latitude,
        lng = ~longitude,
        label = ~paste0("The brightness is ", brightness, " fire pixels (Kelvin) on ", acq_date),
        color = ~palette_fn(prep_nasa_modis_brightness[[acq_date == input$acq_date]]),
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

