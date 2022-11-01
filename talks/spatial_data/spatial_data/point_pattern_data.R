
# Step 1. load the dataset ####
load("C:/Users/felip/OneDrive/proyects/geocoding_mex/2021/den_mex_2021/9.RData_geocoded/den2021_positivos.RData")

# Step 2. extract the locality boundary ####
gua <- rgeomex::extract_ageb(locality =  c("Guadalajara", "Tlaquepaque", 
                                           "Zapopan", "Tonalá"),
                             cve_geo = "14") 

# Step 3. extract the dengue cases by locality ####

# Step 3.1 transform the dengue cases geocoded in sf object ####
z <- z |>
    sf::st_as_sf(coords = c("long", "lat"),
                 crs = 4326)

# Step 3.2 extract the dengue cases in the locality of guadalajara ####

z_cases <- z[gua$locality, ] 

# Step 4. check the dengue cases by locality

# Step 4.1 create the palette ###
z_cases$week_factor <- factor(z_cases$SEM)

pal_fac <- leaflet::colorFactor(palette = fishualize::fish(n = length(unique(z_cases$week_factor)),
                                                       option = "Scarus_hoefleri",
                                                       direction = -1),
                            domain = z_cases$week_factor)

pal_num <- leaflet::colorNumeric(palette = fishualize::fish(n = length(unique(z_cases$SEM)),
                                                       option = "Scarus_hoefleri",
                                                       direction = -1),
                            domain = z_cases$SEM)


l <- leaflet::leaflet(data = z_cases) |>
    leaflet::addTiles()|>
    leaflet::addCircleMarkers(radius = 7,
                              fillColor = ~pal_fac(week_factor),
                              fillOpacity = 1,
                              stroke = 3,
                              weight = 2,
                              color = "white",
                              opacity = .8) |>
    leaflet::addLegend(pal = pal_fac,
                       values = z_cases$week_factor,
                       opacity = 1,
                       title = "Semana",
                       position = "topright")
esri <- grep("^Esri|OpenTopoMap|OpenStreetMap|HERE|CartoDB|NASAGIBS", leaflet::providers, value = TRUE)


for (provider in esri) {
    l <- l |> leaflet::addProviderTiles(provider,
                                         group = provider)
}

l <- l |>
    leaflet::addLayersControl(baseGroups = names(esri),
                              options = leaflet::layersControlOptions(collapsed = TRUE)) |>
    leaflet::addMiniMap(tiles = esri[[1]],
                        toggleDisplay = TRUE,
                        position = "bottomleft") |>
    htmlwidgets::onRender(" function(el, x) {
            var myMap = this;
      myMap.on('baselayerchange',
        function (e) {
          myMap.minimap.changeLayer(L.tileLayer.provider(e.name));
        })
    }")

save(l,
     file = "8.RData/point_pattern_data_gua.RData")








