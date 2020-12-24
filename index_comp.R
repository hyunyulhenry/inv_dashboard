url = 'https://www.investing.com/equities/united-states'
data = GET(url)

# view-source:https://www.investing.com/equities/united-states
# selectBox 부분 보면 id와 주가지수 나와있음

data_parse = data %>% read_html() %>%
   html_nodes('#stocksFilter') %>% html_nodes('option')

data_table = data.frame('id' = data_parse %>% html_attr('id'),
           'name' = data_parse %>% html_text())

url2 = 'https://www.investing.com/equities/StocksFilter?noconstruct=1&smlID=800&sid=&tabletype=price&index_id=169'
# url2 = 'https://www.investing.com/equities/StocksFilter?noconstruct=1&smlID=800&sid=&tabletype=price&index_id=all'
url2 = 'https://www.investing.com/equities/united-states'

GET(url2) %>% read_html() %>% html_table()