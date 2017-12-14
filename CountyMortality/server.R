#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
percent_map <- function(var, color, legend.title, min = 0, max = 100) {
  
  # generate vector of fill colors for map
  shades <- colorRampPalette(c("white", color))(100)
  
  # constrain gradient to percents that occur between min and max
  var <- pmax(var, min)
  var <- pmin(var, max)
  percents <- as.integer(cut(var, 100, 
                             include.lowest = TRUE, ordered = TRUE))
  fills <- shades[percents]
  
  # plot choropleth map
  map("county", fill = TRUE, col = fills, 
      resolution = 0, lty = 0, projection = "polyconic", 
      myborder = 0, mar = c(0,0,0,0))
  
  # overlay state borders
  map("state", col = "white", fill = FALSE, add = TRUE,
      lty = 1, lwd = 1, projection = "polyconic", 
      myborder = 0, mar = c(0,0,0,0))
  
  # add a legend
  inc <- (max - min) / 4
  legend.text <- c(paste0(min, " % or less"),
                   paste0(min + inc, " %"),
                   paste0(min + 2 * inc, " %"),
                   paste0(min + 3 * inc, " %"),
                   paste0(max, " % or more"))
  
  legend("bottomleft", 
         legend = legend.text, 
         fill = shades[c(1, 25, 50, 75, 100)], 
         title = legend.title)
}

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
  output$map <- renderPlot({
    
    data <- switch(input$var, 
                   "HIV" <- results$`HIV14$HIVtreediff`,
                   "Maternal Disorders" <- results$`MAT14$MATtreediff`,
                   "Common Infectious Diseases" <- results$`INF14$INFtreediff`,
                   "Neglected Tropical Diseases" <- results$`TROP14$TROPtreediff`,  
                   "Neonatal Disorders" <- results$`NEON14$NEONtreediff`, 
                   "OTHC" <- results$`OTHC14$OTHCtreediff`,
                   "Neoplasms" <- results$`NEOP14$NEOPtreediff`)
    
    
    percent_map(results, "darkred", "USA", input$range[1], input$range[2])
    
  })
  
})
