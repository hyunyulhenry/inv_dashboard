source('read_pack.R')

ui <- dashboardPage(

  # Header
  dashboardHeader(title = 'Investing Dashboard', titleWidth = 220),
  
  # Side
  source('output_sidebar.R', local = TRUE)$value,
  
  # Body
  dashboardBody(
    source('output_int.R', local = TRUE)$value
  )
)


server <- function(input, output) {
  
  source('read_int_rate.R', local = TRUE)
  source('read_ui.R', local = TRUE)
  

}

shinyApp(ui, server)
