tabItems(
  
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

