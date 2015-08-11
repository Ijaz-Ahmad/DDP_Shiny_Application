## Define user-interface definition for application that predicts miles per galon
library(shiny)
shinyUI(pageWithSidebar(
        
        ## Applcation title
        headerPanel("Mileage Prediction"),
        
        ## Sidebar with controls to select type of vehicle (Automatic or Manual)
        sidebarPanel(
                radioButtons("am", "Transmission Type:",
                             choices = c("Automatic", "Manual"), "Automatic"),
                sliderInput("cyl", "Number of cylinders:", min = 4, max = 12, value = 6, step = 2),
                sliderInput("disp", "Displacement:", min = 70, max = 600, value = 100, step = 10),
                sliderInput("hp", "Gross Horsepower:", min = 50, max = 5000, value = 150, step = 10),
                sliderInput("wt", "Weight:", min = 1, max = 6, value = 3, step = 0.5)),
        
        ## Show a tabset that includes a prediction and plot
        mainPanel(
                tabPanel("Prediction", h1(textOutput("mpg"))),
                tabPanel("Plot", plotOutput("plot")))
))