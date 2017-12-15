#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(maps)
library(ggplot2)
library(dplyr)
library(choroplethr)
library(googlesheets)
library(choroplethrMaps)


results <- read.csv("results.csv")

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  titlePanel("County Level Mortality"),
  
  sidebarLayout(
    sidebarPanel (
      
    helpText("See how accurately our predictive models are able to predict 
             the mortality rate for a given cause of death."),
    
    selectInput("var",
                
                label = "Choose Cause of Death",
                
                choices = list("HIV", "Maternal Disorders", "Common Infectious Diseases",
                               "Neglected Tropical Diseases", "Neonatal Disorders", "Nutritional Deficiencies",
                               "Other Communicable, Maternal, Neonatal and Nutritional Diseases", 
                               "Neoplasms", "Chronic Respiratory Diseases", "Cirrhosis and Chronic Liver Diseases",
                               "Digestive Diseases", "Neurological Disorders", "Mental and Substance Use Disorders",
                               "Diabetes, Urogenital, Blood and Endocrine Diseases", "Musculoskeletal  Disorders",
                               "Other Non-communicable Diseases", "Transport Injuries", "Unintentional Injuries",
                               "Self-harm and Interpersonal Violence", "Forces of Nature, War, and Legal Intervention"),
                
                selected = "HIV"),
   
      
    selectInput("model", 
                
               label = "Choose Model", 
                
               choices = list("Actual Mortality Rates per 10,000", "Regression Tree Estimate Error", "kNN Estimate Error"), 
                
               selected = "Actual Mortality Rates")
    ),
    

  
  mainPanel(plotOutput("map"), width = 12,
            h6("*For model estimates, our legend refers to error rates. i.e. a '1.5' means our model overestimates the deaths per 10,000 by 150%" ))
    )
  )
)
