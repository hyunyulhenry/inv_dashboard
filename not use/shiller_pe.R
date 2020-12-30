library(rvest)
library(httr)
library(dplyr)
library(lubridate)
library(stringr)
library(magrittr)
library(plotly)

Sys.setlocale("LC_ALL", "English")

url = 'https://www.multpl.com/shiller-pe/table/by-month'
data = GET(url)

# Download table
data_table = data %>% read_html() %>% html_table() %>% .[[1]]
data_table = data_table %>%
  mutate(Date = as.Date(Date, format = "%B %d, %Y")) %>%
  set_colnames(c('Date', 'Value'))

# Graph
data_table %>%
  plot_ly(x = ~Date, y = ~Value) %>%
  add_lines() %>%
  layout(xaxis = list(title = ''), yaxis = list(title = ''))


