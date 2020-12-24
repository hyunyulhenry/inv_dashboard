output$bond_time_type = renderUI({
  radioGroupButtons(
    inputId = "bond_time_type",
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

bond_time_interval = reactive({
  
  res = switch(input$bond_time_type,
               '1' = days(1),
               '5' = days(1),
               '15' = days(2),
               '60' = days(5),
               'D' = months(3),
               'M' = years(5)
               )  
  return(res)
  
})


output$date_int = renderUI({
  dateRangeInput(inputId= 'date_int', label = NULL,
                 start = Sys.Date() - years(3),
                 end = Sys.Date(),
                 min = '1962-01-02',
                 max = Sys.Date(),
                 format = "yyyy-mm-dd",
                 separator = " - ")
})

output$int = renderUI({
  checkboxGroupButtons(
    inputId = "int",
    choices = c('30Y', '10Y', '2Y'),
    selected = c('30Y', '10Y', '2Y'),
    checkIcon = list(
      yes = tags$i(class = "fa fa-check-square", 
                 style = "color: steelblue"),
      no = tags$i(class = "fa fa-square-o", 
                  style = "color: steelblue"))
  )
})

output$yield_spread = renderUI({
  checkboxGroupButtons(
    inputId = "yield_spread",
    choices = c('10Y-2Y', '10Y-3M'),
    selected = c('10Y-2Y', '10Y-3M'),
    checkIcon = list(
      yes = tags$i(class = "fa fa-check-square", 
                   style = "color: steelblue"),
      no = tags$i(class = "fa fa-square-o", 
                  style = "color: steelblue"))
  )
})

output$bond_country = renderUI({
  pickerInput(
    inputId = "bond_country",
    choices = get_gov_bond()$Country,
    selected = c('China', 'Germany', 'Japan', 'South Korea', 'United States'),
    multiple = TRUE,
    options = list(`live-search` = TRUE,
                   `actions-box` = TRUE)
  )
  
})

