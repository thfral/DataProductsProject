library(shiny)

pageWithSidebar(
  # Header
  headerPanel('Iris k-means clustering'),
  # Input panel
  sidebarPanel(
    numericInput('clusters', 'Cluster count', 3,
                 min = 1, max = 9),
    checkboxInput("sepal", "Show Sepal Chart", TRUE),
    checkboxInput("petal", "Show Petal Chart", TRUE)
  ),
  # Chart panel
  mainPanel(
    conditionalPanel("input.sepal",
                     plotOutput('plot1')
    ),
    conditionalPanel("input.petal",
                     plotOutput('plot2')
    )
  )
)