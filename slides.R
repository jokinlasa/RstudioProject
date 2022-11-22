
# Load R packages
library(shiny)
library(rgdal)
library(leaflet)
library(readr)
library(dplyr)
library(ggplot2)
Chocolate <- read_csv("chocolate_bars.csv")

# Define UI
ui <- fluidPage(navbarPage(
                  "Chocolate",
                  tabPanel("Rating",
                           sidebarPanel(
                             sliderInput(inputId = "percentage",
                                         label = "cocoa percentage:",
                                         min = min(Chocolate$cocoa_percent),
                                         max = max(Chocolate$cocoa_percent),
                                         value =  c(45, 50))
                           ), # sidebarPanel
                           mainPanel(
                             plotOutput(outputId = "plot")
                             
                           ) # mainPanel
                           
                  ), # Navbar 1, tabPanel
                  tabPanel("Location"),
                  tabPanel("ingredients", "This panel is intentionally left blank")
                  
                )
) # fluidPage


# Define server function  
server <- function(input, output) {
  
  data <- reactive({Chocolate %>% filter(between (cocoa_percent,input$percentage[1], input$percentage[2]))})
  
  output$plot <- renderPlot({
    ggplot(data(), aes(x=rating)) + geom_histogram()
  })
  
} # server


# Create Shiny object
shinyApp(ui = ui, server = server)
