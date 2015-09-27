library(shiny)
library(caret)
library(RColorBrewer)
library(ggplot2)
data(airquality)


shinyServer(function(input,output) {
  YColumn <- reactive({
    grep(input$YVar, names(airquality))
  })
  XColumn <- reactive({
    grep(input$XVar, names(airquality))
  })
  ColorColumn <- reactive({
    grep(input$Col, names(airquality))
  })
  output$Plot <- renderPlot(
    qplot(x = airquality[,XColumn()], y = airquality[,YColumn()], color = airquality[,ColorColumn()], geom="point", size=I(5)) +
      xlab(input$XVar) +
      ylab(input$YVar) +
      scale_colour_continuous(name = input$Col)
  )
  df_pred <- reactive({
    df <- data.frame(airquality[,YColumn()])
    names(df)[1] <- input$YVar
    if ("Ozone" %in% input$Predictors) df$Ozone = airquality$Ozone
    if ("Solar.R" %in% input$Predictors) df$Solar.R = airquality$Solar.R
    if ("Wind" %in% input$Predictors) df$Wind = airquality$Wind
    if ("Temp" %in% input$Predictors) df$Temp = airquality$Temp
    df
  })
  
  model <- reactive({
    if (input$YVar == "Ozone") retmodel = train(Ozone ~ ., data=df_pred(), method="lm")
    if (input$YVar == "Solar.R") retmodel = train(Solar.R ~ ., data=df_pred(), method="lm")
    if (input$YVar == "Wind") retmodel = train(Wind ~ ., data=df_pred(), method="lm")
    if (input$YVar == "Temp") retmodel = train(Temp ~ ., data=df_pred(), method="lm")
    retmodel
  })
  
  output$ModelSummary <- renderPrint(summary(model()))
  
  output$ModelOutput <- renderPrint(model())
  
})