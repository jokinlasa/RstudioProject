library(shiny)
library(readr)
library(dplyr)
library(ggplot2)

# Define UI for app that draws a histogram ----
ui <- fluidPage(
  
  # App title ----
  titlePanel("Ozone level!"),
  
  # Sidebar layout with input and output definitions ----
  sidebarLayout(
    
    # Sidebar panel for inputs ----
    sidebarPanel(
      
      # Input: Slider for the number of bins ----
      sliderInput(inputId = "percentage",
                  label = "cocoa percentage:",
                  min = 1,
                  max = 100,
                  value = 50)
      
    ),
    
    # Main panel for displaying outputs ----
    mainPanel(
      
      # Output: Histogram ----
      plotOutput(outputId = "plot")
      
    )
  )
)

Chocolate <- read_csv("chocolate_bars.csv")

# Define server logic required to draw a histogram ----
server <- function(input, output) {
  
#  ratings <- reactive({
   # percentage <- input$percentage
  #})
  data <- reactive({filter(Chocolate,
                           cocoa_percent == input$percentage)})
  
  output$plot <- renderPlot({
       ggplot(data(), aes(x=rating)) + geom_histogram()
  })
  
}

# Create Shiny app ----
shinyApp(ui = ui, server = server)
