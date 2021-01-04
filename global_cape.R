library(jsonlite)
library(magrittr)
library(dplyr)
library(httr)
library(rvest)
library(tidyr)
library(tibble)

url = 'https://www.starcapital.de/fileadmin/charts/Res_Aktienmarktbewertungen_FundamentalKZ_Tbl.php?lang=en'
data = fromJSON(url)

col_name = data$cols$label

data$rows %>% lapply(., data.frame) %>% .$c %>% t() %>% set_colnames(col_name) %>%
  data.frame() %>% set_rownames(NULL) %>%
  mutate_at(vars(-c('Country')), as.numeric)
