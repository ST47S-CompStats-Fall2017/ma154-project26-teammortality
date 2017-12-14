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
library(fiftystater)
library(leaflet)
library(dplyr)
library(choroplethr)

county <- map_data("county")


shinyServer(function(input, output) {
   
  output$map <- renderPlot({
    
    data <- switch(input$var, 
                   "HIV Actual" = results$HIVreal,
                   "HIV Tree" = results$HIVtreediff,
                   "HIV kNN" = results$HIVknndiff,
                   "Maternal Disorders Actual" = results$MATreal,
                   "Common Infectious Diseases Actual" = results$INFreal,
                   "Neglected Tropical Diseases Actual" = results$TROPreal,  
                   "Neonatal Disorders Actual" = results$NEONreal, 
                   "OTHC Actual" = results$OTHCreal,
                   "Neoplasms Actual" = results$NEOPreal)
    
    names <- switch(input$var,
                    "HIV Actual" = "HIV Deaths per 10,000",
                    "HIV Tree" =  "Regression Tree Model: HIV prediction errors",
                    "HIV kNN" = "kNN Model: HIV prediction errors", 
                    "Maternal Disorders Actual" = "Maternal Disorders Deaths per 10,000",
                    "Common Infectious Diseases Actual" = "Common Infectious Disease Deaths per 10,000",
                    "Neglected Tropical Diseases Actual" = "Neglected Tropical Disease Deaths per 10,000",  
                    "Neonatal Disorders Actual" = "Neonatal Disorder Deaths per 10,000", 
                    "OTHC Actual" = "Other Communicable, Maternal, Neonatal, and Nutritional Disease Deaths per 10,000",
                    "Neoplasms Actual" = "Neoplasm Deaths per 10,000")
    
    results.to.use <- results %>% mutate(region = fips, value = data * -1)
    
    county_choropleth(results.to.use, title = names, num_colors = 1)
    
    

  })
  
})
