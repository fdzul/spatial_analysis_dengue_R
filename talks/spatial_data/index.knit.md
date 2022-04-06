---
title: "Datos Espaciales"
author: "Felipe Antonio Dzul Manzanilla"
date: '2022: Last compiled 2022-04-05'
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
# Tipos de mapas
<hr style="height:2px;border-width:0;color:#330019;background-color:#330019">




