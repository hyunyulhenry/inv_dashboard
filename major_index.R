url = 'https://www.investing.com/indices/major-indices'

data = GET('https://www.investing.com/indices/major-indices')

data_table = data %>% read_html() %>%
  html_nodes(xpath = '//*[@id="cross_rates_container"]/table') %>%
  html_table() %>%
  .[[1]]

head(data_table)

data_table %>% .[!duplicated(colnames(.))] %>%
  dplyr::select('Index', 'Last', 'Chg. %') %>%
  filter(Index %in% c('Dow Jones', 'S&P 500', 'Nasdaq', 'Small Cap 2000',
                      'S&P 500 VIX', 'KOSPI', '')
         )
