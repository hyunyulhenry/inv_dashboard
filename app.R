source('read_pack.R')

ui <- dashboardPage(

  # Header
  dashboardHeader(title = 'Investing Dashboard', titleWidth = 220),
  
  # Side
  source('output_sidebar.R', local = TRUE)$value,
  
  # Body
  dashboardBody(
    source('output_body.R', local = TRUE)$value
  )
)


server <- function(input, output) {
  
  # Crawling
  source('read_eq.R', local = TRUE)
  source('read_int_rate.R', local = TRUE)
  
  # UI
  source('read_ui_eq.R', local = TRUE)
  source('read_ui_bond.R', local = TRUE)
  

}

shinyApp(ui, server)
