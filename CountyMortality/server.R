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
library(choroplethr)

county <- map_data("county")

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
  output$map <- renderPlot({
    
    data <- switch(input$var, 
                   "HIV" = results$`HIV14$HIVtreediff`,
                   "Maternal Disorders" = results$`MAT14$MATtreediff`,
                   "Common Infectious Diseases" = results$`INF14$INFtreediff`,
                   "Neglected Tropical Diseases" = results$`TROP14$TROPtreediff`,  
                   "Neonatal Disorders" = results$`NEON14$NEONtreediff`, 
                   "OTHC" = results$`OTHC14$OTHCtreediff`,
                   "Neoplasms" = results$`NEOP14$NEOPtreediff`)
    
    #ggplot() +
      #geom_map(data=county, map=county, aes(x=long, y=lat, map_id=region), col="white", fill="grey")
      #geom_polygon(data = results, aes(x = long, y = lat, group = group, fill = var))
    
    
    county_choropleth(results)
    choro = CountyChoropleth$new(df_pop_county)
    choro$title = "Mortality Model Estimates"
    choro$ggplot_scale = scale_fill_brewer(name="Mortality", palette=2, drop=FALSE)
    choro$render()
    

  })
  
})
