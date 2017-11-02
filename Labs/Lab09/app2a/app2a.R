
library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(
  
  # Application title
  titlePanel("Drawing Balls Experiment"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      sliderInput("bins",
                  "Number of bins:",
                  min = 1,
                  max = 5000,
                  value = 2500),
      sliderInput("threshold",
                  label = "Threshold for choosing boxes:",
                  min = 0,
                  max = 1,
                  value = 0.5)
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("freqs_plot")
    )
  )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
  output$freqs_plot <- renderPlot({
    # where the magic happens
    box1 <- c('blue', 'blue', 'red')
    box2 <- c('blue', 'blue', 'red', 'red', 'red', 'red', 'white')
    
    drawn_balls <- list()
    
    # (repeated 1000 times)
    for (i in 1:input$bins)
    {
      rand_num <- runif(1)
      if (rand_num > input$threshold)
        result <- sample(box1, size = 4, replace = TRUE) # w/ replacement
      else if (rand_num < input$threshold)
        result <- sample(box2, size = 4, replace = FALSE) # w/o replacement
      drawn_balls[[i]] <- result
    }
    drawn_balls <- as.data.frame(do.call("rbind", drawn_balls)) 
    
    count <- 0
    blue0 <- 0
    blue1 <- 0
    blue2 <- 0
    blue3 <- 0
    blue4 <- 0
    
    blue0_prob <- 0
    blue1_prob <- 0
    blue2_prob <- 0
    blue3_prob <- 0
    blue4_prob <- 0
    probs <- list()
    
    for (i in 1:input$bins){
      for (j in 1:4){
        if (drawn_balls[i, j] == 'blue')
          count <- count + 1
      }
      if (count == 0){
        blue0 <- blue0 + 1
        blue0_prob <- blue0 / i
      }
      else if (count == 1){
        blue1 <- blue1 + 1
        blue1_prob <- blue1 / i
      }
      else if (count == 2){
        blue2 <- blue2 + 1
        blue2_prob <- blue2 / i
      }
      else if (count == 3){
        blue3 <- blue3 + 1
        blue3_prob <- blue3 / i
      }
      else if (count == 4){
        blue4 <- blue4 + 1
        blue4_prob <- blue4 / i
      }
      
      prob_v <- (c(i, blue0_prob, blue1_prob, blue2_prob, blue3_prob, blue4_prob))
      probs[[i]] <-  prob_v
      
      count <- 0
    }
    
    probs <- as.data.frame(do.call("rbind", probs))
    
    #convert counts to probabilities/ratios
    blue0_prob <- blue0 / 1000
    blue1_prob <- blue1 / 1000
    blue2_prob <- blue2 / 1000
    blue3_prob <- blue3 / 1000
    blue4_prob <- blue4 / 1000
    
    probs %>%
      gather(key,value, V2, V3, V4, V5, V6) %>%
      ggplot(aes(x=V1, y=value, colour=key)) +
      geom_line() +
      ggtitle("Relative frequencies of number of blue balls")
    
  })
}

# Run the application 
shinyApp(ui = ui, server = server)

