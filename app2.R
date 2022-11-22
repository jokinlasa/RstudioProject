library(shiny)
library(readr)
library(dplyr)
library(ggplot2)
library(ggvis)

Chocolate <- read_csv("chocolate_bars_2.csv")


# Define UI for app that draws a histogram ----
ui <- fluidPage(
  
  # App title ----
  titlePanel("Ozone level!"),
  
  # Sidebar layout with input and output definitions ----
  
    
    # Main panel for displaying outputs ----
    mainPanel(
      
      # Output: Histogram ----
      ggvisOutput("plot")
      
    )
  )



# Define server logic required to draw a histogram ----
server <- function(input, output) {
  
#  ratings <- reactive({
   # percentage <- input$percentage
  #})
  # Function for generating tooltip text
  cocoa_tooltip <- function(x) {
    if (is.null(x)) return(NULL)
    if (is.null(x$id)) return(NULL)
    
    # Pick out the movie with this ID
    bar<- Chocolate[Chocolate$id_x == x$id_x, ]

    paste0("<b> Bar name: ", bar$bar_name, "</b><br> manufacturer:",
           bar$manufacturer, "<br> bean origin: ",
           bar$bean_origin
    )
  }
  vis <- (
    {
      Chocolate %>% ggvis(~cocoa_percent, ~rating, key:=~id_x ) %>%
        layer_points() %>%
        add_tooltip(cocoa_tooltip, "hover") %>%
        add_axis("x", title = "percentage") %>%
        add_axis("y", title = "rating")
      
    }
  )
  vis %>% bind_shiny("plot")
}

# Create Shiny app ----
shinyApp(ui = ui, server = server)
