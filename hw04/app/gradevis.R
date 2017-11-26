###################################
# title: "HW04 Grade Visualizer App"
# subtitle: "Stat 133, Fall 2017"
# author: "Tyler Larsen"
###################################

library(shiny)
library(ggvis)

#source("functions.R")

# Define UI for application that draws a histogram
ui <- fluidPage(
  
  # Application title
  titlePanel("Grade Visualizer"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      selectInput("select", label = h3("X-axis variable"), 
                  choices = list("HW1" = "HW1", 
                                 "HW2" = "HW2",
                                 "HW3" = "HW3",
                                 "HW4" = "HW4",
                                 "HW5" = "HW5",
                                 "HW6" = "HW6",
                                 "HW7" = "HW7",
                                 "HW8" = "HW8",
                                 "HW9" = "HW9",
                                 "Attendence" = "ATT",
                                 "Quiz 1" = "QZ1",
                                 "Quiz 2" = "QZ2",
                                 "Quiz 3" = "QZ3",
                                 "Quiz 4" = "QZ4",
                                 "Exam 1" = "EX1",
                                 "Exam 2" = "EX2",
                                 "Lab" = "Lab",
                                 "Overall Homework" = "Homework",
                                 "Overall Quiz" = "Quiz",
                                 "Overall Percent Grade" = "Overall"), 
                  selected = "HW1"),
      sliderInput("width",
                  "Bin width",
                  min = 1,
                  max = 10,
                  value = 1)
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      tabsetPanel(
        tabPanel("Barchart", plotOutput("idk_yet")),
        tabPanel("Histogram", ggvisOutput("distPlot"), verbatimTextOutput("summary")),
        tabPanel("Scatterplot", str("idk_yet"))
    )
  )
)
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
  vis_plot <- reactive({
    
    xvar <- prop("x", as.symbol(input$select))

    histogram <- dat %>%
      ggvis(x = xvar) %>%
      layer_histograms(stroke := 'white', width = input$width)
  })
  
  
  vis_plot %>% bind_shiny("distPlot")
  
 
}


# Run the application 
shinyApp(ui = ui, server = server)

