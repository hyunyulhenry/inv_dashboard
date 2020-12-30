dashboardSidebar(
  width = 220,
  sidebarMenu(
    menuItem("Equity", icon = icon("building"),
             menuSubItem("Chart", tabName = "eq_chart"),
             menuSubItem("Sector Data", tabName = "eq_sector_data")
             ),
    
    menuItem("Interest Rate", icon = icon("percent"),
             menuSubItem("Chart", tabName = "int_chart"),
             menuSubItem("Major Index", tabName = "int"),
             menuSubItem("Government Bonds", tabName = "gov_bond"))
  )
)