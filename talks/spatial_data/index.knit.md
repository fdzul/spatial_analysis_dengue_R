---
title: "Datos Espaciales"
author: "Felipe Antonio Dzul Manzanilla"
date: '2022: Last compiled 2022-10-25'
output:
  xaringan::moon_reader:
    lib_dir: libs
    css: 
      - default
      - default-fonts
      - duke-blue
      - hygge-duke
      - libs/cc-fonts.css
      - libs/figure-captions.css
    nature:
      highlightStyle: github
      highlightLines: true
      countIncrementalSlides: false
---

class: left, top



<!--html_preserve--><style>.xe__progress-bar__container {
  top:0;
  opacity: 1;
  position:absolute;
  right:0;
  left: 0;
}
.xe__progress-bar {
  height: 0.25em;
  background-color: #0051BA;
  width: calc(var(--slide-current) / var(--slide-total) * 100%);
}
.remark-visible .xe__progress-bar {
  animation: xe__progress-bar__wipe 200ms forwards;
  animation-timing-function: cubic-bezier(.86,0,.07,1);
}
@keyframes xe__progress-bar__wipe {
  0% { width: calc(var(--slide-previous) / var(--slide-total) * 100%); }
  100% { width: calc(var(--slide-current) / var(--slide-total) * 100%); }
}</style><!--/html_preserve-->





<!--html_preserve--><div>
<style type="text/css">.xaringan-extra-logo {
width: 310px;
height: 428px;
z-index: 0;
background-image: url(https://www.ssaver.gob.mx/wp-content/uploads/2021/04/cropped-logoencabezado6abr2.jpg);
background-size: contain;
background-repeat: no-repeat;
position: absolute;
top:1em;right:1em;
}
</style>
<script>(function () {
  let tries = 0
  function addLogo () {
    if (typeof slideshow === 'undefined') {
      tries += 1
      if (tries < 10) {
        setTimeout(addLogo, 100)
      }
    } else {
      document.querySelectorAll('.remark-slide-content:not(.title-slide):not(.inverse):not(.hide_logo)')
        .forEach(function (slide) {
          const logo = document.createElement('div')
          logo.classList = 'xaringan-extra-logo'
          logo.href = null
          slide.appendChild(logo)
        })
    }
  }
  document.addEventListener('DOMContentLoaded', addLogo)
})()</script>
</div><!--/html_preserve-->

# **Temas**
<hr style="height:2px;border-width:0;color:#330019;background-color:#330019">

- Datos espaciales.
&nbsp;

- Tipos de Mapas.
&nbsp;

- Información básica para un mapa.
&nbsp;

- Mapas estáticos en R.
  -  Mapas en base.
  -  Mapas en ggplot2.
  -  Mapas en tmap.
  -  Mapas en mapsf..
&nbsp;

- Mapas interactivos en R
  - leaflet
  - plolty
  - tmap
  - mapview


---
# Clasificación de los Datos Espaciales
<hr style="height:2px;border-width:0;color:#330019;background-color:#330019">

<!--html_preserve--><div id="htmlwidget-291e3ef98ad19606a619" style="width:100%;height:504px;" class="grViz html-widget"></div>
<script type="application/json" data-for="htmlwidget-291e3ef98ad19606a619">{"x":{"diagram":"digraph {\n                  # graph definitions\n  graph [layout = dot, rankdir = TB]\n  \n  # node definitions\n  node [shape = rectangle, \n  style = filled, \n  color = grey, \n  nodesep = .5,\n  fixedsize = true, \n  width = 2] \n  \n  # edge definition\n  edge [color = grey, arrowhead = normal, arrowtail = dot]\n  \n  ##### Spatial Data\n  \n  areal [label = \"Areal Data\",  fillcolor =  \" #0F9D58\", color = \"white\", fontcolor = \"white\"]\n  lattice_data [label = \"Lattice Data\",  fillcolor =  \" #0F9D58\", color = \"white\", fontcolor = \"white\"]\n  pp_data [label = \"Point Pattern Data\",  fillcolor =  \" #0F9D58\", color = \"white\", fontcolor = \"white\"]\n  geo_data [label = \"Geostatistical Data\",  fillcolor =  \" #0F9D58\", color = \"white\", fontcolor = \"white\"]\n  spatial_data [label = \"Spatial Data\",  fillcolor =  \" #0F9D58\", color = \"white\", fontcolor = \"white\"]\n  \n  \n  \n  #####\n \n  \n # \n continuo [label = \"Continuo\",  fillcolor =  \"#F4B400\", color = \"white\", fontcolor = \"black\"]\n discrete [label = \"Discreto\",  fillcolor =  \"#F4B400\", color = \"white\", fontcolor = \"black\"]\n \n #\n fixed  [label = \"Fijo\",  fillcolor =  \"#4285F4\", color = \"white\", fontcolor = \"white\"]\n random  [label = \"Aleatorio\",  fillcolor =  \"#4285F4\", color = \"white\", fontcolor = \"white\"]\n \n regular  [label = \"Regular\",  fillcolor =  \"#4285F4\", color = \"white\", fontcolor = \"white\"]\n irregular  [label = \"Irregular\",  fillcolor =  \"#4285F4\", color = \"white\", fontcolor = \"white\"]\n \n # examples\n cases [label = \"Casos\",  fillcolor =  \"#DB4437\", color = \"white\", fontcolor = \"white\"]\n ovitraps [label = \"Ovitrampas\",  fillcolor =  \"#DB4437\", color = \"white\", fontcolor = \"white\"]\n ageb [label = \"Casos/colonia/ageb\",  fillcolor =  \"#DB4437\", color = \"white\", fontcolor = \"white\"]\n grid [label = \"Casos/areas geométricas\",  fillcolor =  \"#DB4437\", color = \"white\", fontcolor = \"white\"]\n \n ##### define the relation\n \n #\n spatial_data -> {continuo discrete} \n continuo -> {fixed random}\n discrete -> {regular, irregular}\n fixed -> geo_data\n random -> pp_data\n irregular -> areal\n regular -> lattice_data\n pp_data -> cases\n geo_data -> ovitraps\n areal -> ageb\n lattice_data -> grid\n\n \n \n  \n}","config":{"engine":"dot","options":null}},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->




.footnote[[Krainski et al 2019](https://www.taylorfrancis.com/books/mono/10.1201/9780429031892/advanced-spatial-modeling-stochastic-partial-differential-equations-using-inla-elias-krainski-virgilio-g%C3%B3mez-rubio-haakon-bakka-amanda-lenzi-daniela-castro-camilo-daniel-simpson-finn-lindgren-h%C3%A5vard-rue)]


---
# Tipos de mapas
<hr style="height:2px;border-width:0;color:#330019;background-color:#330019">
<!--html_preserve--><div id="htmlwidget-679f2b1b1bd5f2ad16a2" style="width:100%;height:504px;" class="grViz html-widget"></div>
<script type="application/json" data-for="htmlwidget-679f2b1b1bd5f2ad16a2">{"x":{"diagram":"digraph {\n                  # graph definitions\n  graph [layout = dot, rankdir = TB]\n  \n  # node definitions\n  node [shape = rectangle, \n  style = filled, \n  color = grey, \n  nodesep = .5,\n  fixedsize = true, \n  width = 2] \n  \n  # edge definition\n  edge [color = grey, arrowhead = normal, arrowtail = dot]\n  \n  ##### Spatial Data\n  \n  areal [label = \"Areal Data\",  fillcolor =  \" #0F9D58\", color = \"white\", fontcolor = \"white\"]\n  pp_data [label = \"Point Pattern Data\",  fillcolor =  \" #0F9D58\", color = \"white\", fontcolor = \"white\"]\n  geo_data [label = \"Geostatistical Data\",  fillcolor =  \" #0F9D58\", color = \"white\", fontcolor = \"white\"]\n  spatial_data [label = \"Spatial Data\",  fillcolor =  \" #0F9D58\", color = \"white\", fontcolor = \"white\"]\n  \n  ##### map type\n  maps [label = \"Maps\",  fillcolor =  \"DodgerBlue\", color = \"white\", fontcolor = \"white\"]\n  static [label = \"Static\",  fillcolor =  \"DodgerBlue\", color = \"white\", fontcolor = \"white\"]\n  interactive [label = \"Interactive\",  fillcolor =  \"DodgerBlue\", color = \"white\", fontcolor = \"white\"]\n  animated [label = \"Animated\",  fillcolor =  \"DodgerBlue\", color = \"white\", fontcolor = \"white\"]\n  \n  satellital [label = \"Satellital\",  fillcolor =  \"#8BC3FC\", color = \"white\", fontcolor = \"white\"]\n  no_satellital [label = \"Non Satellital\",  fillcolor =  \"#8BC3FC\", color = \"white\", fontcolor = \"white\"]\n  \n  ##### packages\n  \n  # static maps\n base_r [label = \"Base R\",  fillcolor =  \"orange\", color = \"white\", fontcolor = \"black\"]\n lattice [label = \"lattice\",  fillcolor =  \"orange\", color = \"white\", fontcolor = \"black\"]\n ggplot [label = \"ggplot2\",  fillcolor =  \"orange\", color = \"white\", fontcolor = \"black\"]\n ggspatial [label = \"ggspatial\",  fillcolor =  \"orange\", color = \"white\", fontcolor = \"black\"]\n ggmap [label = \"ggmap\",  fillcolor =  \"orange\", color = \"white\", fontcolor = \"black\"]\n tmap [label = \"tmap\",  fillcolor =  \"orange\", color = \"white\", fontcolor = \"black\"]\n cartography [label = \"cartography\",  fillcolor =  \"orange\", color = \"white\", fontcolor = \"black\"]\n mapsf [label = \"mapsf\",  fillcolor =  \"orange\", color = \"white\", fontcolor = \"black\"]\n  \n # intercative maps\n leaflet [label = \"leaflet\",  fillcolor =  \"orange\", color = \"white\", fontcolor = \"black\"]\n mapview [label = \"mapview\",  fillcolor =  \"orange\", color = \"white\", fontcolor = \"black\"]\n \n # animated maps\n \n \n ##### define the relation\n \n # Static maps\n spatial_data -> {areal pp_data geo_data} -> maps -> {static interactive animated}\n static -> {satellital, no_satellital} -> base_r\n base_r -> {lattice ggplot tmap cartography, mapsf}\n ggplot -> {ggmap ggspatial}\n\n # Interactive maps\n interactive -> {leaflet tmap mapview}\n \n # animated maps\n \n animated -> {ggplot tmap}\n \n  \n}","config":{"engine":"dot","options":null}},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->



---
# Datos Espaciales 



.panelset[

.panel[.panel-name[Point Pattern Data]













