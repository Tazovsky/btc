
ui <- fluidPage(
  
  # Application title
  titlePanel("Bitmarket.pl marketplace"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      selectInput("market", "select market:", market, "BTCPLN"),
      selectInput("interval", "Select interval:", names(.last.90.ticks), selected = "90m")
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      plotlyOutput("plot")
    )
  )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
  data <- eventReactive(list(input$interval, input$market), {
    req(input$interval)
    req(input$market)
    
    progress <- Progress$new(min = 0, max = 1)
    
    progress$set(value = 0.5, message = "Downloading data")
    last90url <- getLast90ticksUrl(input$interval, input$
                                     market, .markets)
    
    data <- getDataFromUrl(last90url)
    
    progress$set(value = 1, message = "100% done")
    
    progress$close()
    
    data
  })
  
  output$plot <- renderPlotly({
    req(data())
    
    data() %>%
      plot_ly(x = ~time, type = "candlestick",
              open = ~open, close = ~close,
              high = ~high, low = ~low) %>%
      layout(title = input$market)
    
  })
}

# Run the application 
shinyApp(ui = ui, server = server)

