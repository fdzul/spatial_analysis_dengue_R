
library(sf)
library(magrittr)
file.choose()

source('C:/Users/felip/OneDrive/cursos_impartidos/2021/foro_estadistica/3.Functions/block_surveillance.R')
#path_coord <- "C:/Users/felip/Dropbox/cenaprece_datasets/30_veracruz/DescargaOvitrampasMesFco.txt"
path_coord <- "C:/Users/felip/Dropbox/cenaprece_datasets/2022/30_veracruz/DescargaOvitrampasMesFco.txt"
blocks_surveillance(locality = "Poza Rica De Hidalgo",
                    cve_geo = "30",
                    path_coords = path_coord)


# prediction of the number of eggs in the metropolitan area of Merida
deneggs::eggs_hotspots(path_lect = "C:/Users/felip/Dropbox/cenaprece_datasets/2022/31_yucatan",
                       cve_ent = "31",
                       locality  = c("Mérida"),
                       path_coord =  "C:/Users/felip/Dropbox/cenaprece_datasets/2022/31_yucatan/DescargaOvitrampasMesFco.txt",
                       longitude  = "Pocision_X",
                       latitude =  "Pocision_Y",
                       aproximation = "gaussian",
                       integration = "eb",
                       fam = "zeroinflatednbinomial1",
                       k = 30,
                       palette_vir  = "magma",
                       leg_title = "Huevos",
                       plot = FALSE,
                       hist_dataset = FALSE, #####
                       sem = lubridate::epiweek(Sys.Date())-2,
                       var = "eggs",
                       cell_size = 1000,
                       alpha = .99)$map



# prediction of the number of eggs in the metropolitan area of Guadalajara
guadalajata_12 <- deneggs::eggs_hotspots(path_lect = "C:/Users/felip/Dropbox/cenaprece_datasets/2022/14_jalisco",
                                         cve_ent = "14",
                                         locality  = c("Guadalajara", "Tlaquepaque", "Zapopan", "Tonalá"),
                                         path_coord =  "C:/Users/felip/Dropbox/cenaprece_datasets/2022/14_jalisco/DescargaOvitrampasMesFco.txt",
                                         longitude  = "Pocision_X",
                                         latitude =  "Pocision_Y",
                                         aproximation = "gaussian",
                                         integration = "eb",
                                         fam = "zeroinflatednbinomial1",
                                         k = 40,
                                         palette_vir  = "magma",
                                         leg_title = "Huevos",
                                         plot = FALSE,
                                         hist_dataset = FALSE, #####
                                         sem = lubridate::epiweek(Sys.Date())-2,
                                         var = "eggs",
                                         cell_size = 1000,
                                         alpha = .99)
guadalajara_12 <- guadalajata_12 
save(guadalajara_12,
     file = "8.RData/guadalajara_12.RData")


ggplot2::ggsave(filename = "6.Maps/static_maps/guadalajara_eggs_12.jpg",
                dpi = 300,
                bg = "white")



# Step 2. load the dataset ####
load("C:/Users/felip/OneDrive/cursos_impartidos/2022/maps_R/8.RData/guadalajara_12.RData")

# Step 1. extract the data ####
x <- guadalajara_12$data |>
    sf::st_as_sf(coords = c("Pocision_X", "Pocision_Y"),
                 crs = 4326)

# Step 2. extract the locality ###
loc <- guadalajara_12$loc


# Step 3. load of block ####
blocks <- rgeomex::blocks_ine20_mx_b[loc,]

# Step 4. extract the blocks ####
blocks_ovitraps <- blocks[x,]

# Step 5. define the palette ####
pal_num <- leaflet::colorNumeric(palette = fishualize::fish(n = length(unique(x$eggs)),
                                                            option = "Scarus_hoefleri",
                                                            direction = -1),
                                 domain = x$eggs)

l <- leaflet::leaflet() |>
    leaflet::addTiles() |>
    leaflet::addPolygons(data = blocks_ovitraps,
                         group = "blocks",
                         weight = 2,
                         opacity = .8) |>
    leaflet::addCircleMarkers(data = x |> dplyr::filter(eggs == 0),
                              group = "ovitraps_negative",
                              radius = 5,
                              fillColor = "red",
                              fillOpacity = 1,
                              stroke = 3,
                              weight = 2,
                              color = "white",
                              opacity = .8) |>
    leaflet::addCircleMarkers(data = x |> dplyr::filter(eggs > 0),
                              group = "ovitraps",
                              radius = 5,
                              fillColor = ~pal_num(eggs),
                              fillOpacity = 1,
                              stroke = 3,
                              weight = 2,
                              color = "white",
                              opacity = .8) |>
    leaflet::addLegend(pal = pal_num,
                       values = x$eggs,
                       opacity = 1,
                       title = "Números de Huevos",
                       position = "topright") 
esri <- grep("^Esri|OpenTopoMap|OpenStreetMap|HERE|CartoDB|NASAGIBS", leaflet::providers, value = TRUE)


for (provider in esri) {
    l <- l |> leaflet::addProviderTiles(provider,
                                        group = provider)
}

l <- l |>
    leaflet::addLayersControl(baseGroups = names(esri),
                              options = leaflet::layersControlOptions(collapsed = TRUE),
                              overlayGroups = c("blocks", "ovitraps_negative", "ovitraps")) |>
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
l

save(file = "8.RData")





