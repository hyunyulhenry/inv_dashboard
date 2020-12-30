library(quantmod)
library(tidyr)
library(shiny)
library(shinydashboard)
library(dashboardthemes)
library(dplyr)
library(shinyWidgets)
library(magrittr)
library(plotly)
library(lubridate)
library(httr)
library(rvest)
library(DT)
library(kableExtra)
library(jsonlite)
library(stringr)
library(readr)
library(purrr)

sector_graph =
  
  c('https://finviz.com/grp_image.ashx?sec_basicmaterials.png&rev=637448042873150086',
    'https://finviz.com/grp_image.ashx?sec_communicationservices.png&rev=637448042873150086',
    'https://finviz.com/grp_image.ashx?sec_consumercyclical.png&rev=637448042873150086',
    'https://finviz.com/grp_image.ashx?sec_consumerdefensive.png&rev=637448042873150086',
    'https://finviz.com/grp_image.ashx?sec_energy.png&rev=637448042873150086',
    'https://finviz.com/grp_image.ashx?sec_financial.png&rev=637448042873150086',
    'https://finviz.com/grp_image.ashx?sec_healthcare.png&rev=637448042873150086',
    'https://finviz.com/grp_image.ashx?sec_industrials.png&rev=637448042873150086',
    'https://finviz.com/grp_image.ashx?sec_realestate.png&rev=637448042873150086',
    'https://finviz.com/grp_image.ashx?sec_technology.png&rev=637448042873150086',
    'https://finviz.com/grp_image.ashx?sec_utilities.png&rev=637448042873150086'
  )
