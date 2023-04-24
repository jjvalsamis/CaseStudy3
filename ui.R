library(shiny)
library(ggplot2)
readfile <- read.csv(file = 'mlb_hitting.csv')
readfile_no_names <- readfile[, c("Games", "Hits","At.bat","Runs", "Double..2B.", "third.baseman","home.run", "run.batted.in")]
clean_mlb <- na.omit(readfile_no_names)
dataset <- clean_mlb

fluidPage(
  
  titlePanel("MLB Hitting Data"),
  
  sidebarPanel(
    
    sliderInput('sampleSize', 'Sample Size', min=1, max=nrow(dataset),
                value=min(1000, nrow(dataset)), step=500, round=0),
    
    selectInput('x', 'X', names(dataset)),
    selectInput('y', 'Y', names(dataset), names(dataset)[[2]]),
    selectInput('color', 'Color', c('None', names(dataset))),
    
    numericInput('clusters', 'Cluster count', 3, min = 1, max = 9),

  ),
  
  mainPanel(
    plotOutput('plot')
  )
)
