# Equity Chart
output$eq_chart = renderPlotly({
  
  req(input$eq_time_type)
  
  Sys.setenv(TZ='Asia/Seoul')
  
  from = as.numeric(Sys.time() - eq_time_interval() ) %>% round(., 0)
  to = as.numeric(Sys.time()) %>% round(., 0)
  type = input$eq_time_type
  
  sym = switch(input$eq_index,
               'S&P 500' = 166,
               'Dow Jones' = 169,
               'NASDAQ 100' = 20,
               'Russell 2000' = 170,
               'KOSPI 200' = 37427,
               'KOSDAQ' = 38016
  )  
  
  url = paste0('https://tvc4.forexpros.com/42e8e550f4c5b6c619b946b85ed93a9a/1609207062/1/1/8/history?symbol=',
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

# Read Sector table
get_sector = reactive({
  
  withProgress(message = 'Download Data', value = 0, {
    
  url = c('https://finviz.com/grp_export.ashx?g=sector&v=110&o=name',
          'https://finviz.com/grp_export.ashx?g=sector&v=120&o=name',
          'https://finviz.com/grp_export.ashx?g=sector&v=140&o=name')
  
  down = lapply(url, function(x) {        
    GET(x) %>%
      read_html() %>%
      html_text() %>%
      read_csv()
  })
  
  })
  
  return(down)
})

# Sector Table (DT)
output$sector_table = renderDataTable({
  
  get_sector() %>%
    reduce(inner_join) %>% select(`Name`, `Market Cap`, `Dividend Yield`, `P/E`, `Forward P/E`,
                                  `PEG`, `P/S`, `P/B`, `P/C`, `P/Free Cash Flow`, `EPS growth past 5 years`,
                                  `EPS growth next 5 years`,`Change`, `Performance (Week)`, `Performance (Month)`, `Performance (Quarter)`,
                                  `Performance (Half Year)`, `Performance (Year)`, `Performance (Year To Date)`) %>%
    set_colnames(c('Name', 'Cap(B)', 'DY', 'PER','PER(F)', 'PEG', 'PSR', 'PBR', 'PCR', 'PFCF',
                   'EPS Past 5Y', 'EPS Next 5Y', 'Perf(D)', 'Perf(W)', 'Perf(M)', 'Perf(Q)', 'Perf(Half)', 'Per(Y)', 'Perf(YTD)')) %>%
    mutate('Cap(B)' = `Cap(B)` / 1000) %>%
    arrange(desc(`Cap(B)`)) %>%
    DT::datatable(rownames = FALSE, 
                  options = list(dom = 'tB',
                                 pageLength = 1000000,
                                 columnDefs = list(list(className = 'dt-right', targets = c(1:18)))
                  )) %>%
    formatCurrency('Cap(B)',currency = "", interval = 3, mark = ",")
  
})


# Sector Return Bar Chart
output$sector_ret = renderPlotly({
  
  sec_tb =
    get_sector() %>%
    reduce(inner_join) %>% select(`Name`, `Change`, `Performance (Week)`, `Performance (Month)`, `Performance (Quarter)`,
                                  `Performance (Half Year)`, `Performance (Year)`, `Performance (Year To Date)`) %>%
    set_colnames(c('Name', 'Day', 'Week', 'Month', 'Quarter', 'Half', 'Year', 'YTD')) %>%
    mutate_at(vars(-Name), parse_number) %>%
    gather(key, value, -Name) %>%
    mutate(color = ifelse(value > 0, 'red', 'blue')) 
  
  (sec_tb %>%
    ggplot(aes(x = Name, y = value, fill = color)) +
    geom_bar(stat = 'identity') +
    coord_flip() +
    scale_fill_identity() +
    theme_classic() + 
    scale_x_discrete(limits = rev) +
    facet_wrap(. ~ key, scales = 'free', ncol = 1) +
    xlab(NULL) + ylab('(%)') +
    theme(strip.background = element_blank())
  ) %>% ggplotly() %>%
    hide_legend()
  
})


# Sector Return (Chart)

  

