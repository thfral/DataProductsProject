library(shiny)

function(input, output, session) {
  
  dataset <- iris
  dataset$SpeciesChar <- ifelse(dataset$Species == 'setosa', 'S', ifelse(dataset$Species == 'versicolor', 'V', 'I'))
  
  # Combine the Sepal variables into a new data frame
  selectedData1 <- reactive({
    dataset[, c('Sepal.Length', 'Sepal.Width')]
  })
  
  # Combine the Petal variables into a new data frame
  selectedData2 <- reactive({
    dataset[, c('Petal.Length', 'Petal.Width')]
  })
  
  # Execute the kmeans function with Sepal values
  clusters1 <- reactive({
    kmeans(selectedData1(), input$clusters)
  })
  
  # Execute the kmeans function with Petal values
  clusters2 <- reactive({
    kmeans(selectedData2(), input$clusters)
  })
  
  # Sepal Chart
  output$plot1 <- renderPlot({
    
    plot(selectedData1(),
         col = clusters1()$cluster,
         pch = as.character(dataset$SpeciesChar), 
         cex = 2)
    points(clusters1()$centers, pch = 4, cex = 4, lwd = 4)
  })
  
  # Petal Chart
  output$plot2 <- renderPlot({
    
    plot(selectedData2(),
         col = clusters2()$cluster,
         pch = as.character(dataset$SpeciesChar), 
         cex = 2)
    points(clusters2()$centers, pch = 4, cex = 4, lwd = 4)
  })
  
}