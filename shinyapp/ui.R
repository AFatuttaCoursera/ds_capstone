##initialization 
suppressPackageStartupMessages(c(
    library(shinythemes),
    library(shiny),
    library(shinyjs)
))

##css info needed for the loading screen
appCSS <- " 
 #loading-content { 
   position: absolute; 
   background: #000000; 
   opacity: 0.9; 
   z-index: 100; 
   left: 0; 
   right: 0; 
   height: 100%; 
   text-align: center; 
   color: #FFFFFF; 
 } 
 " 


# Define UI for capstone application
shinyUI( 
fluidPage(
    useShinyjs(), 
    
    inlineCSS(appCSS), 
    
    div(
        id="loading-content",
        tags$span(style="color:white",
                  h2("Please wait few seconds while the application is loading..")
        )
    ),
    
    hidden(
        div(
            id="app-content",
    navbarPage ( "Data Science Capstone Project",
                  theme = shinytheme("cosmo"),
                
                 ##howto
                 tabPanel(  
                     "Introduction",
                     fluidRow(
                         column(2,
                                p("")),
                         column(8,
                                includeMarkdown("./instructions/instructions.md")
                                ),
                         column(2,
                                p(""))
                     )
                 ),
            ##startappPanel
            tabPanel( # Application title
                      "Text Prediction App",
                      fluidRow(
                          column(3,
                                 p("")),
                          column(6,
                                 h4(tags$strong("Completed sentence with first option:"),style="color:black"),
                                 tags$span(style="color:darkgreen",
                                           h4(textOutput("completeSent"))
                                            ),
                                 tags$br(),
                                 h4(tags$strong("Predicted next words:"),style="color:black"),
                                 tags$span(style="color:green",
                                           h4(htmlOutput("predictedWord"))
                                           ),
                                 tags$br(),
                                 tags$h4 (tags$span(style="color:black",textInput("textInput", label="Enter your text here:", value = "I have a test")))
                                 ),
                          column(3,
                                 p(""))
                      )
                      
                    ), ##endapp
            ##aboutPanel
            tabPanel(  
                "About the project",
                fluidRow(
                    column(2,
                           p("")),
                    column(8,
                           includeMarkdown("./about/about.md")
                           ),
                    column(2,
                           p(""))
                    )
                )
            )
          )##end hidden div
        )## end hidden
    )##endfluidpage
  )

