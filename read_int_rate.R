get_int = reactive({
  
  symbols = c("DGS30","DGS10","DGS2","T10Y2Y","T10Y3M","T10YIE")
  
  withProgress(message = 'Download Data', value = 0, {
    n = length(symbols)
    for (i in 1:n) {
      
      getSymbols(symbols[i], src='FRED')
      incProgress(1/n)
    }
  })
  
  int_bind = cbind(DGS30, DGS10, DGS2, T10Y2Y, T10Y3M, T10YIE) %>%
    fortify.zoo
  
  
  return(int_bind)
})

get_gov_bond = reactive({
  
  withProgress(message = 'Download Data', value = 0, {
    
    url = 'https://www.investing.com/rates-bonds/government-bond-spreads'
    bond_data = GET(url) %>% read_html() %>% html_table() %>% .[[1]] %>%
      select(Country, Yield, `Chg.`, `Chg. %`)
    
  })
  
  return(bond_data)
  
})

output$int_bond = renderPlotly({
  
  req(input$int)
  
  get_int() %>%
    select(Index, DGS30, DGS10, DGS2) %>% na.omit() %>%
    set_colnames(c('Index', '30Y', '10Y', '2Y')) %>%
    filter(Index >= input$date_int[[1]]) %>%
    filter(Index <= input$date_int[[2]]) %>%
    select(Index, input$int) %>%
    gather(key, value, -Index) %>%
    mutate(key = base::factor(key, levels = c('30Y', '10Y', '2Y'))) %>%
    plot_ly(x = ~Index, y = ~value) %>%
    add_paths(color = ~key) %>%
    layout(legend = list(orientation = "h"),
           xaxis = list(title = NA),
           yaxis = list(title = '(%)'))
})

output$int_spread = renderPlotly({
  
  req(input$yield_spread)
  
  get_int() %>%
    select(Index, T10Y2Y, T10Y3M) %>% na.omit() %>%
    set_colnames(c('Index', '10Y-2Y', '10Y-3M')) %>%
    filter(Index >= input$date_int[[1]]) %>%
    filter(Index <= input$date_int[[2]]) %>%
    select(Index, input$yield_spread) %>%
    gather(key, value, -Index) %>%
    mutate(key = base::factor(key, levels = c('10Y-2Y', '10Y-3M'))) %>%
    plot_ly(x = ~Index, y = ~value) %>%
    add_paths(color = ~key) %>%
    layout(legend = list(orientation = "h"),
           xaxis = list(title = NA),
           yaxis = list(title = '(%)'))
})

output$int_bei = renderPlotly({
  
  req(input$date_int[[1]])
  
  get_int() %>%
    select(Index, T10YIE) %>% na.omit() %>%
    set_colnames(c('Index', '10Y BEI')) %>%
    filter(Index >= input$date_int[[1]]) %>%
    filter(Index <= input$date_int[[2]]) %>%
    gather(key, value, -Index) %>%
    plot_ly(x = ~Index, y = ~value) %>%
    add_paths(color = ~key) %>%
    layout(legend = list(orientation = "h"),
           xaxis = list(title = NA),
           yaxis = list(title = '(%)'))
})

output$int_gov_bond = renderDataTable({
  
  get_gov_bond() %>%
    mutate(test = ifelse(str_sub(`Chg.`, 1, 1) == '+', 1, 0)) %>%
    mutate(
      `Chg.` = cell_spec(`Chg.`, color = ifelse(test == 1, "red", "blue")),
      `Chg. %` = cell_spec(`Chg. %`, color = ifelse(test == 1, "red", "blue"))
    ) %>%
    select(-test) %>%
    filter(Country %in% input$bond_country) %>%
    DT::datatable(rownames = FALSE, 
                  options = list(dom = 'tB',
                                 pageLength = 1000000,
                                 columnDefs = list(list(className = 'dt-right', targets = c(1:3)))
                  ),
                  escape = FALSE)
  
  
})


output$int_chart = renderPlotly({

  req(input$bond_time_type)
  
  Sys.setenv(TZ='Asia/Seoul')
  
  from = as.numeric(Sys.time() - bond_time_interval()) %>% round(., 0)
  to = as.numeric(Sys.time()) %>% round(., 0)
  type = input$bond_time_type
  
  sym = switch(input$bond_time_counry,
               'US 10Y' = 23705,
               'KOR 10Y' = 29292
  )  
  
  url = paste0('https://tvc4.forexpros.com/80885e2117b48eae99ebd1ed02d51403/1608791266/1/1/8/history?symbol=',
               sym,'&resolution=', type,
               '&from=', from,
               '&to=', to)
  
  withProgress(message = 'Download Data', value = 0, {
    data = fromJSON(url) %>% do.call(cbind, .)
  })
  
  data_mod = data %>% data.frame() %>% select(t, c, o, h, l) %>%
    mutate_all(as.numeric) %>%
    mutate(t = as.POSIXct(t, origin="1970-01-01"))
    # filter(t >= input$time_int[[1]]) 
    # filter(t <= input$time_int[[2]])
     
  i <- list(line = list(color = 'red'))
  d <- list(line = list(color = 'blue'))
  
  data_mod %>% 
    plot_ly(x = ~t, type="candlestick",
                       open = ~data_mod$o, close = ~data_mod$c,
                       high = ~data_mod$h, low = ~data_mod$l,
                       increasing = i, decreasing = d) %>%
    layout(xaxis = list(title = NA),
           yaxis = list(title = '(%)'))

})
  