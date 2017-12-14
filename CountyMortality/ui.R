#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  titlePanel("County Level Mortality"),
  
  sidebarLayout(
    helpText("See how accurately our predictive models are able to predict 
             the mortality rate for a given cause of death."),
    selectInput("var",
                
                label = "Choose Cause of Death",
                
                choices = list("HIV", "Maternal Disorders", "Common Infectious Diseases",
                               "Neglected Tropical Diseases", "Neonatal Disorders", "OTHC", 
                               "Neoplasms"),
                
                selected = "HIV"),
    ),
  
  mainPanel(plotOutput("map"))
  
  )
)
