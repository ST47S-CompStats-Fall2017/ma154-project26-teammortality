#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
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

#county <- map_data("county")

results <- read.csv("results.csv")
                
shinyServer(function(input, output) {
   
  output$map <- renderPlot({
    
    cause.of.death <- switch(input$var, 
                   "HIV" = "HIV",
                   "Maternal Disorders" = "MAT",
                   "Common Infectious Diseases" = "INF",
                   "Neglected Tropical Diseases" = "TROP",  
                   "Neonatal Disorders" = "NEON", 
                   "Nutritional Deficiencies" = "NUT",
                   "Other Communicable, Maternal, Neonatal and Nutritional Diseases" = "OTHC",
                   "Neoplasms" = "NEOP",
                   "Chronic Respiratory Diseases" = "CHRON", 
                   "Cirrhosis and Chronic Liver Diseases" = "CIRR",
                   "Digestive Diseases" = "DIG", 
                   "Neurological Disorders" = "NEUR",
                   "Mental and Substance Use Disorders" = "MENSUB", 
                   "Diabetes, Urogenital, Blood and Endocrine Diseases" = "DIAB", 
                   "Musculoskeletal  Disorders" = "MUSC", 
                   "Other Non-communicable Diseases" = "OTHN",
                   "Transport Injuries" = "TRAN",
                   "Unintentional Injuries" = "UNIN", 
                   "Self-harm and Interpersonal Violence" = "SELF",
                   "Forces of Nature, War, and Legal Intervention" = "WAR")
    
   model.choice <- switch(input$model,
                   "Actual Mortality Rates per 10,000" = "real", 
                   "Regression Tree Estimate Error" = "tree", 
                   "kNN Estimate Error" = "knn")
    
    
    results.to.use <- results %>% filter(model == model.choice) %>% filter(cause == cause.of.death) %>% 
                              mutate(region = fips) %>% mutate(value = mortrate)
    
    
    county_choropleth(results.to.use, num_colors = 1)
    
    

  })
  
})
