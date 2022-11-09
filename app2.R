library(shiny)
library(readr)
library(dplyr)

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
      plotOutput(outputId = "distPlot")
      
    )
  )
)

# Define server logic required to draw a histogram ----
server <- function(input, output) {
  
  Chocolate <- read_csv("chocolate_bars.csv")
   y <- reactive({Chocolate %>%
    filter(percentage == input$percentage) %>%
   count(Chocolate$rating, input$percentage)})

  y<-reactive({input$percentage})
  output$distPlot <- renderPlot({
    therating <- Chocolate$rating
    therating <- na.omit(therating)

    
    hist(x=therating, breaks = y, col = "#75AADB", border = "black",
         xlab = "rating",
         main = "Histogram of how many rating")
    
  })
  
}

# Create Shiny app ----
shinyApp(ui = ui, server = server)
