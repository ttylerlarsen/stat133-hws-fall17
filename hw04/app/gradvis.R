###################################
# title: "HW04 Grade Visualizer App"
# subtitle: "Stat 133, Fall 2017"
# author: "Tyler Larsen"
###################################

# required packages
library(shiny)
library(ggvis)
library(dplyr)

# convert some variables as factors, for barcharts

dat$Grade <- factor(dat$Grade, 
                    levels = c('A+', 'A', 'A-','B+','B', 
                               'B-','C+', 'C', 'C-', 'D', 'F'))


# Variable names for histograms
dat_cols <- c("HW1", "HW2", "HW3", "HW4", "HW5", "HW6", "HW7","HW8", "HW9",
              "ATT", "QZ1", "QZ2", "QZ3", "QZ4", "EX1","EX2", "Test1",
              "Test2", "Lab", "Homework", "Quiz","Overall")
lines <- c("None", "Lm", "Loess")


# Define UI for application that draws a histogram
ui <- fluidPage(
  
  # Application title
  titlePanel("Grade Visualizer"),
  
  # Sidebar with different widgets depending on the selected tab
  sidebarLayout(
    sidebarPanel(
      conditionalPanel(condition = "input.tabselected==1",
                       h3("Grades Distribution"),
                       tableOutput("freq_chart")),
      conditionalPanel(condition = "input.tabselected==2",
                       selectInput("var2", "X-axis variable", dat_cols, 
                                   selected = "HW2"),
                       sliderInput("width2", "Bin Width", 
                                   min = 1, max = 10, value = 10)),
      conditionalPanel(condition = "input.tabselected==3",
                       selectInput("var3", "X-axis variable", dat_cols,
                                   selected = "Test1"),
                       selectInput("var4", "Y-axis variable", dat_cols,
                                   selected = "Overall"),
                       sliderInput("var5", "Opacity", 
                                   min = 0, max = 1, value = .5),
                       radioButtons("var6", "Show lines", lines,
                                    selected = "None"))
      
    ),
    mainPanel(
      tabsetPanel(type = "tabs",
                  tabPanel("Barchart", value = 1, 
                           ggvisOutput("barchart")
                           ),
                  tabPanel("Histogram", value = 2, 
                           ggvisOutput("histogram"),
                           tableOutput("sum_stats")),
                  tabPanel("Scatterplot", value = 3, 
                           ggvisOutput("scatterplot"),
                           verbatimTextOutput("correlation")),
                  id = "tabselected")
    )
  )
)


# Define server logic
server <- function(input, output) {
  
  #Barchart (for 1st tab)
  ###################################################################
  vis_barchart <- ggvis(dat, ~factor(Grade), fill := "#7DA8F1") %>% #
    add_axis("x", title = "Grade") %>%                              #
    add_axis("y", title = "Frequency")                              #
  vis_barchart %>% bind_shiny("barchart")                           #
                                                                    #
  output$freq_chart <- renderTable({                                #
    freq_table                                                      #
    })                                                              #
  ###################################################################
  
  
  
  
  
  
  # Histogram (for 2nd tab)
  #############################################################
  vis_histogram <- reactive({
    var2 <- prop("x", as.symbol(input$var2))
    col <- input$var2
    df <- print_stats(summary_stats(dat$col))
    
    dat %>% 
      ggvis(x = var2, fill := "#abafb5") %>% 
      layer_histograms(stroke := 'white',
                       width = input$width2)
  })
  vis_histogram %>% bind_shiny("histogram")
  
  x <- input$var2

  output$sum_stats <- renderTable({
    #placeholder df, need to fix print_stats function
  })   
  #############################################################
  
  
  
  
  
  
  
  
  # Scatterplot (for 3rd tab)
  #############################################################
  vis_histogram <- reactive({
    var3 <- prop("x", as.symbol(input$var3))
    var4 <- prop("y", as.symbol(input$var4))
    opacity <- input$var5
    
    
    if (input$var6 == "Lm")
    {
      dat %>% 
        ggvis(x = var3, y = var4, fill := "000000", opacity := input$var5) %>% 
        layer_points() %>%
        layer_model_predictions(model = "lm", se = TRUE)
    }
    else if (input$var6 == "Loess")
    {
      dat %>% 
        ggvis(x = var3, y = var4, fill := "000000", opacity := input$var5) %>% 
        layer_points() %>%
        layer_model_predictions(model = "loess", se = TRUE)
    }
    else
    {
    dat %>% 
      ggvis(x = var3, y = var4, fill := "000000", opacity := input$var5) %>% 
      layer_points()
    }

    
  })
  vis_histogram %>% bind_shiny("scatterplot")
  
  output$correlation <- renderText({
     # how do you get data from the col that corresponds to var3/4?
  })   
  
  #############################################################
}












# Run the application 
shinyApp(ui = ui, server = server)

