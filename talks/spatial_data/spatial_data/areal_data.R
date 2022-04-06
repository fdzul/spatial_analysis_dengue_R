


# Step 1. load the dataset ####
load("C:/Users/felip/OneDrive/proyects/geocoding_mex/2021/den_mex_2021/9.RData_geocoded/den2021_positivos.RData")

# Step 2. extract the locality boundary ####
guadalajara_locality <- rgeomex::extract_ageb(locality =  c("Guadalajara", "Tlaquepaque", 
                                                            "Zapopan", "Tonalá"),
                                              cve_geo = "14") 


# Step 3. count the dengue cases by polygon ####
library(magrittr)
gua_casos <- denhotspots::point_to_polygons(x = z,
                                            y = guadalajara_locality$ageb,
                                            ids = c(names(guadalajara_locality$ageb)[1:(ncol(guadalajara_locality$ageb)-1)]),
                                            time = ANO,
                                            coords = c("long", "lat"),
                                            crs = 4326,
                                            dis = "DENV")


# Step 3. map the dengue cases in guadalajara ####
ggplot2::ggplot() +
    ggplot2::geom_sf(data = guadalajara_locality$ageb,
                        fill = "gray90",
                     color = "white") +
    ggplot2::geom_sf(data = gua_casos |> dplyr::filter(DENV_2021 > 0),
                     ggplot2::aes(fill = DENV_2021)) +
    fishualize::scale_fill_fish("Casos (2021)",
                                option = "Scarus_hoefleri",
                                direction = -1) +
    cowplot::theme_map()






