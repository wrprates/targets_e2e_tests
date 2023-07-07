# R/functions.R
library(shiny)
library(tibble)

server <- function(input, output, session) { 
  output$plot <- renderPlot({
    plot(input$param1, input$param2)
  })
}

test_server_fn <- function(dataset) {
  shiny::testServer(server, {
    session$setInputs(param1 = dataset$param1, param2 = dataset$param2)
    plot_created <<- !is.null(isolate(output$plot))
  })
  return(plot_created)
}

# Define datasets as a nested tibble
create_demo_datasets <- function(dataset_list) {
  tibble(
    dataset_name = names(dataset_list),
    dataset = dataset_list
  )
}
