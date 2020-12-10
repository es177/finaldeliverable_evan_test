# Map brightness data
library(sf)
library(mapview)
library(ggmap)
library(dplyr)
library(ggplot2)
library(RColorBrewer)

## Working map
nasa_modis_brightness <- read_csv("fire_archive_M6_169855.csv")

#prep_nasa_modis_brightness <- nasa_modis_brightness %>% 
  select(latitude, longitude, brightness, acq_date, daynight)  %>% 
  mutate(acq_date = as.Date(acq_date)) 

prep_nasa_modis_brightness <- nasa_modis_brightness %>% 
  select(latitude, longitude, brightness, acq_date, daynight) %>% 
  filter(acq_date == acq_date) %>% 
  filter(daynight == daynight)

locations_sf <- st_as_sf(prep_nasa_modis_brightness, 
                         coords = c("longitude", "latitude"), crs = 4121)

m <- mapview(locations_sf, cex = "brightness", zoom = 4)


m2 <- leaflet(data = prep_nasa_modis_brightness) %>%
  addProviderTiles("Stamen.TonerLite") %>% 
  addCircleMarkers(
    lat = ~latitude,
    lng = ~longitude,
    fillOpacity = .7,
    radius = 1,
    stroke = FALSE,
    color = "red"
  ) #%>% 
  #addLegend( 
    #position = "bottomright",
    #title = "Brightness fire pixels (Kelvin)",
    #pal = prep_nasa_modis_brightness, 
    #values = prep_nasa_modis_brightness[["brightness"]], 
    #opacity = 1 
  #)
palette_fn <- colorNumeric(
  palette = ("YlOrRd"),
  domain = prep_nasa_modis_brightness[["brightness"]],
  reverse = TRUE
)

leaflet(data = prep_nasa_modis_brightness) %>%
  addProviderTiles("Stamen.TonerLite") %>% 
  addCircleMarkers(
    lat = ~latitude,
    lng = ~longitude,
    label = ~paste0("The brightness is ", brightness, " fire pixels (Kelvin) on ", acq_date),
    color = ~palette_fn(prep_nasa_modis_brightness[["brightness"]]),
    fillOpacity = .7,
    radius = 1,
    stroke = FALSE#,
    #color = "red"
  ) %>% 
  addLegend(pal = palette_fn, na.label = "NA", bins = 5, 
            values = ~brightness, title = "Brightnesss") 


