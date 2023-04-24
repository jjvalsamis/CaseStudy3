library(shiny)
library(ggplot2)
library(cluster)

readfile <- read.csv(file = 'mlb_hitting.csv')
readfile_no_names <- readfile[, c("Games", "Hits","At.bat","Runs", "Double..2B.", "third.baseman","home.run", "run.batted.in")]
clean_mlb <- na.omit(readfile_no_names)
dataset <- clean_mlb

function(input, output) {
  
  dataset <- reactive({
    clean_mlb[sample(nrow(clean_mlb), input$sampleSize),]
  })
  
  clusters <- reactive({
    kmeans(dataset(), input$clusters)
  })
    
  output$plot <- renderPlot({
    
    p <- ggplot(dataset(), aes_string(x=input$x, y=input$y)) + geom_point(color=clusters()$cluster)

    print(p)
  }, height=700)
  
}
