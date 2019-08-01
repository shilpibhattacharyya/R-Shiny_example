library(shiny)

# Define UI for app that draws a histogram ----
ui <- fluidPage(
  tags$head(tags$style(
    HTML('
         #sidebar {
            background-color: #dfe6ed;
        }

        body, label, input, button, select { 
          font-family: "Arial";
        }')
  )),
  # App title ----
  titlePanel("Interactive plot on the Old Faithful Geyser Data"),
  # Sidebar layout with input and output definitions ----
  sidebarLayout(
    
    # Sidebar panel for inputs ----
    sidebarPanel(id="sidebar",
      
      # Input: Slider for the number of bins ----
      sliderInput(inputId = "bins",
                  label = "Number of bins:",
                  min = 1,
                  max = 50,
                  value = 30),
      
      
      br()
      
      #img(src='data_sample.png',align = "left")
      
    ),
    
    # Main panel for displaying outputs ----
    mainPanel(
      
      p(strong("Old Faithful Geyser Data (From R manual)"),"is a data frame with 272 observations on 2 variables - 
      eruptions: numeric Eruption time in mins and waiting: numeric Waiting time to next eruption. 
      The waiting time between eruptions and the duration of the eruption in this dataframe is
     for the Old Faithful geyser in Yellowstone National Park, Wyoming,
     USA. Hence the name."),
      
      #img(src='data_sample.png', width="10%",align = "right"),
      # Output: Histogram ---
      plotOutput(outputId = "distPlot1"),
      plotOutput(outputId = "distPlot")
    )
  )
)

# Define server logic required to draw a histogram ----
server <- function(input, output) {
  
  # Histogram of the Old Faithful Geyser Data ----
  # with requested number of bins
  # This expression that generates a histogram is wrapped in a call
  # to renderPlot to indicate that:
  #
  # 1. It is "reactive" and therefore should be automatically
  #    re-executed when inputs (input$bins) change
  # 2. Its output type is a plot
  output$distPlot <- renderPlot({
    
    x    <- faithful$waiting
    bins <- seq(min(x), max(x), length.out = input$bins + 1)
    
    hist(x, breaks = bins, col = "#db8475", border = "white",
         xlab = "Waiting time to next eruption (in mins)",
         main = "Histogram of waiting times")
    
    
  })
  br()
  br()
  br()
  output$distPlot1 <- renderPlot({
    
    x1    <- faithful$eruptions
    bins <- seq(min(x1), max(x1), length.out = input$bins + 1)
    
    hist(x1, breaks = bins, col = "#db75d6", border = "white",
         xlab = "Eruption time (in mins)",
         main = "Histogram of eruption time")
    
  })
  
}

shinyApp(ui = ui, server = server)
