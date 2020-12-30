tabItems(
  
  # Equity
  tabItem("eq_chart",
          fluidRow(
            column(width = 12, height = 700,
                   uiOutput('eq_index'),
                   uiOutput('eq_time_type'), 
                   plotlyOutput('eq_chart', height = 600)
                   
            )
          )
  ),
  
  
  tabItem("eq_sector_data",
          fluidRow(
            tabBox(
              width = 12,
              tabPanel('Sector Data',
                       dataTableOutput('sector_table')
                       ),
              tabPanel('Sector Return',
                        plotlyOutput('sector_ret', height = 1500)
              ),
              tabPanel('Sector Graph',
                       fluidRow(
                         div(style = 'overflow-y:scroll; height:800px;',
                           column(width = 6, img(src = sector_graph[1], width="100%")),
                           column(width = 6, img(src = sector_graph[2], width="100%")),
                           br(),
                           column(width = 6, img(src = sector_graph[3], width="100%")),
                           column(width = 6, img(src = sector_graph[4], width="100%")),
                           br(),
                           column(width = 6, img(src = sector_graph[5], width="100%")),
                           column(width = 6, img(src = sector_graph[6], width="100%")),
                           br(),
                           column(width = 6, img(src = sector_graph[7], width="100%")),
                           column(width = 6, img(src = sector_graph[8], width="100%")),
                           br(),
                           column(width = 6, img(src = sector_graph[9], width="100%")),
                           column(width = 6, img(src = sector_graph[10], width="100%")),
                           br(),
                           column(width = 6, img(src = sector_graph[11], width="100%"))
                         )
                       )
              )
              )
            )
          ),
  
  
  
  # Bond
  tabItem("int_chart",
          fluidRow(
            column(width = 12, height = 700,
                   
                   uiOutput('bond_time_counry'),
                   uiOutput('bond_time_type'), 
                   plotlyOutput('int_chart', height = 600)
                   
            )
          )
  ),
  
  tabItem("int",
          fluidRow(
            column(width = 12, uiOutput('date_int')),
            tabBox(
              width = 12, height = 700,
              
              tabPanel('US Yield',
                           uiOutput('int'),
                           plotlyOutput('int_bond', height = 600)
                           ),
                  
              tabPanel('Yield Spread',
                           uiOutput('yield_spread'),
                           plotlyOutput('int_spread', height = 600)
                           ),
                  
              tabPanel('Break Even Inflation',
                           plotlyOutput('int_bei', height = 600)
                       )
                 
                )
              )
          ),

  tabItem("gov_bond",
            fluidRow(
              column(width = 12, height = 700,
                     uiOutput('bond_country'),
                     div(style = 'overflow-y:scroll;height:600px;',
                              dataTableOutput('int_gov_bond')
                     )
                         
                )
              )
            )
)

