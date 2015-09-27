library(shiny)

shinyUI(pageWithSidebar(
  
  headerPanel("Air Quality Dataset Manipulation"),
  
  sidebarPanel(
    selectInput("YVar", "Dependant Variable", choices=c("Ozone","Solar.R", "Wind", "Temp"), selected=c("Ozone")),
    selectInput("XVar", "Plot X Variable", choices=c("Ozone", "Solar.R", "Wind", "Temp"), selected = c("Temp")),
    selectInput("Col", "Plot Colored By", choices=c("Ozone", "Solar.R", "Wind", "Temp"), selected = c("Solar.R")),
    selectInput("Predictors", "Predictor(s)", multiple=TRUE, choices=c("Ozone", "Solar.R", "Wind", "Temp"), selected = c("Temp"))
  ),
  mainPanel(
    plotOutput("Plot"),
    verbatimTextOutput("ModelSummary"),
    verbatimTextOutput("ModelOutput")
  )
  
))