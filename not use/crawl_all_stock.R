library(httr)
library(rvest)

url = 'https://www.investing.com/stock-screener/Service/SearchStocks'
query = list(
  'country[]' = '5',
  'sector' = '7,5,12,3,8,9,1,6,2,4,10,11',
  'industry' = '81,56,59,41,68,67,88,51,72,47,12,8,50,2,71,9,69,45,46,13,94,102,95,58,100,101,87,31,6,38,79,30,77,28,5,60,18,26,44,35,53,48,49,55,78,7,86,10,1,34,3,11,62,16,24,20,54,33,83,29,76,37,90,85,82,22,14,17,19,43,89,96,57,84,93,27,74,97,4,73,36,42,98,65,70,40,99,39,92,75,66,63,21,25,64,61,32,91,52,23,15,80',
  'equityType' = 'ORD',
  'exchange[]' = '2',
  'pn' = '5',
  'order[col]' = 'eq_market_cap',
  'order[dir]' = 'd'
)

data = POST(url, query)
data %>% read_html %>% html_nodes(xpath = '//*[@id="resultsTable"]/tbody')

url = 'https://www.investing.com/stock-screener/?sp=country::5|sector::a|industry::a|equityType::ORD|exchange::2%3Ceq_market_cap;1'
data = GET(url)

data %>% read_html() %>% html_nodes('#resultsTable') %>% html_nodes('a')
  