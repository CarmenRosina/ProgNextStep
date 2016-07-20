
#### shiny neural netwerk; Werkt. 
library(shiny)

ui<- fluidPage(
  
  # Application title
  titlePanel("Hello Shiny!"),
  
  # Sidebar with a slider input for the number of bins
  sidebarLayout(
    sidebarPanel(
      sliderInput("nodes",
                  "Number of nodes:",
                  min = 1,
                  max = 10,
                  value = 5)
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("nodePlot")
    )
  )
)

server <- (function(input, output) {
  
  output$nodePlot <- renderPlot({
    traininginput <-  as.data.frame(runif(50, min=0, max=100))
    trainingoutput <- sqrt(traininginput)
    
    trainingdata <- cbind(traininginput,trainingoutput)
    colnames(trainingdata) <- c("Input","Output")
    
    library("neuralnet")
    
    net.sqrt <- neuralnet(Output~Input,trainingdata, hidden=input$nodes, threshold=0.01)
    
    library(devtools)
    source_url('https://gist.githubusercontent.com/fawda123/7471137/raw/466c1474d0a505ff044412703516c34f1a4684a5/nnet_plot_update.r')
    
    plot.nnet(net.sqrt)
    
  })
})


shinyApp(ui=ui, server=server)
