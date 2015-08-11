## load required libraries and data
library(shiny); library(datasets); library(shape); data("mtcars")

## Define levels of factor(am)
mtcars$am[mtcars$am == 0] <- "Automatic"
mtcars$am[mtcars$am == 1] <- "Manual"

## Build a prediction model on myData
mod.fit <- lm(mpg ~ am + log(cyl * disp * hp * wt), mtcars)

## Define server logic for application that predicts miles per galon
shinyServer(function(input, output){
        
        ## Reactive expression to predict mpg of the car with requested features
        datasetInput <- reactive({
                ## Create an empty data frame with colnames only
                dat <- data.frame(matrix(0, ncol = 11), stringsAsFactors = FALSE)
                names(dat) <- c("mpg", "cyl", "disp", "hp", "drat",
                                "wt", "qsec", "vs", "am", "gear", "carb")
                dat$mpg <- NULL
                dat$cyl <- input$cyl
                dat$disp <- input$disp
                dat$hp <- input$hp
                dat$wt <- input$wt
                dat$am <- input$am
                round(predict(mod.fit, dat), 1)
                
        })
        
        ## Generate mpg prediction
        output$mpg <- renderPrint({
                cat(paste(datasetInput(), "miles per gallon"))
        })
        
        ## Generate plot
        output$plot <- renderPlot({
                plot(0, 0, type = "n",
                     main = paste("Radius of Inner Circle = Predicted milage / 50 \n",
                     "==> ", round(datasetInput()/50, 2), "inches along x-axis"),
                     frame.plot = FALSE, xlab = " ", ylab = " ", asp = 1/1)
                filledcircle(r2 = datasetInput()/50)
                textflag(mid = c(0,0), radx = 1, rady = .15,
                         lab = paste(input$am, ",",
                                     "Cylinders: ", input$cyl, ",",
                                     "Displacement: ", input$disp, "(cu.in.)", ",",
                                     "Horsepower: ", input$hp, ";",
                                     "Weight: ", input$wt, "(lb/1000)"),
                         col = "lightyellow")
        })
})