
library(shiny)
source("./utils.R")

# Define server logic required to predict data
shinyServer(function(input, output) {
   
        ##data initialization
        loadData()
        
        ##hide loading screen
        hide(id = "loading-content", anim = TRUE, animType = "fade")
    
        ##show app content
        show(id = "app-content")
    
        ##prediction function
        predict <- reactive(
            {
                res <<-getPredictions(strip(input$textInput))
                addTags(res)
            }
        )
        
        ##output writing
        output$predictedWord <- renderText(predict())
      
        output$completeSent <- renderText(paste(input$textInput,res[1]))
  
    }
)
