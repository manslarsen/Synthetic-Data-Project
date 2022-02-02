library(shiny)
library(shinythemes)
library(ggplot2)  # for the originaldata dataset
library(synthpop)
library(data.table)
library(RCurl)
library(DT)


# Read data - 
originaldata <- read.csv(text = getURL("https://raw.githubusercontent.com/manslarsen/Synthetic-Data-Project/main/DataClean.csv"))

# creating syntheticic data
synthdata <- syn(originaldata)  
synthdata <- synthdata$syn

ui <- fluidPage(theme = shinytheme("flatly"),
                
  # Page header
  headerPanel('PewResearch'),
  HTML('<em>2016 Racial Attitudes in America</em>'),              
  # Input values
  sidebarPanel(
    HTML("<h3>Input parameters</h3>"),
    selectInput("show_vars", "Columns in originaldata to show:",multiple = TRUE,
                names(originaldata), selected = names(originaldata)),

  ),
  
  #Mainpanel shows the tabs and outcomes
  mainPanel(
    tabsetPanel(
      id = 'dataset',
      tabPanel("Original Data", DT::dataTableOutput("mytable1")),
      tabPanel("Synthetic Data", DT::dataTableOutput("mytable2")),
      tabPanel("Comparison", plotOutput("plot"))
    )
  ) 
    
    )


server <- function(input, output, clientData, session) {
 
updateSelectInput(session, "show_vars",
                  label = paste("Select variables"),
                  choices = names(originaldata)
  )
  
#original data table  
  originaldata2 = originaldata[sample(nrow(originaldata), 1000), ]
  output$mytable1 <- DT::renderDataTable({
    DT::datatable(originaldata[, input$show_vars, drop = FALSE])
  })

#synthetic data table
  output$mytable2 <- DT::renderDataTable({ 
    DT::datatable(synthdata[, input$show_vars, drop = FALSE])
    })

#comparison plots
  output$plot <- renderPlot({
    compare(synthdata, originaldata, vars = input$show_vars)
  })
  
  
}


shinyApp(ui, server)
