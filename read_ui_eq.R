output$eq_index = renderUI({
  radioGroupButtons(
    inputId = "eq_index",
    choices = c('S&P 500', 'Dow Jones', 'NASDAQ 100', 'Russell 2000',
               'KOSPI 200', 'KOSDAQ'),
    selected = 'S&P 500',
    checkIcon = list(
      yes = tags$i(class = "fa fa-check-square", 
                   style = "color: steelblue"),
      no = tags$i(class = "fa fa-square-o", 
                  style = "color: steelblue"))
  )
})

output$eq_time_type = renderUI({
  radioGroupButtons(
    inputId = "eq_time_type",
    choices = list(
      '1 Min' = '1',
      '5 Min' = '5',
      '15 Min' = '15',
      '1 Hour' = '60',
      'Day' = 'D',
      'Month' = 'M'
    ),
    selected = '15',
    checkIcon = list(
      yes = tags$i(class = "fa fa-check-square", 
                   style = "color: steelblue"),
      no = tags$i(class = "fa fa-square-o", 
                  style = "color: steelblue"))
  )
})

eq_time_interval = reactive({
  
  res = switch(input$eq_time_type,
               '1' = days(1),
               '5' = days(1),
               '15' = days(2),
               '60' = days(5),
               'D' = months(3),
               'M' = years(5)
  )  
  return(res)
  
})