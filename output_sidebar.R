dashboardSidebar(
  width = 220,
  sidebarMenu(
    menuItem("Interest Rate", icon = icon("percent"),
             menuSubItem("Chart", tabName = "int_chart"),
             menuSubItem("Major Index", tabName = "int"),
             menuSubItem("Government Bonds", tabName = "gov_bond"))
  )
)