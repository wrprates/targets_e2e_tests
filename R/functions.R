# R/functions.R
library(purrr)
library(shiny)
library(targets)
library(tibble)

server <- function(input, output, session) { 
  output$plot <- renderPlot({
    # browser()
    plot(input$param1, input$param2)
  })
}

# test_server_fn <- function(dataset) {
#   print(dataset)
#   shiny::testServer(server, {
#     # browser()
#     # Assuming that the datasets always have param1 and param2 columns
#     session$setInputs(param1 = dataset$param1, param2 = dataset$param2)
#     plot_created <<- !is.null(isolate(output$plot))
#   })
#   return(plot_created)
# }

test_server_fn <- function(data_name) {
  # print(dataset)
  shiny::testServer(server, {
    # browser()
    # Assuming that the datasets always have param1 and param2 columns
    session$setInputs(
      param1 = datasets$dataset[data_name][[1]]$param1,
      param2 = datasets$dataset[data_name][[1]]$param2
      
    )
    plot_created <<- !is.null(isolate(output$plot))
  })
  return(plot_created)
}

# Define datasets as a list
create_demo_datasets <- function(dataset_list) {
  # Create datasets tibble
  tibble(
    dataset_name = names(dataset_list),
    dataset = dataset_list
  )
}
