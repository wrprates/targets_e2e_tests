# _targets.R
library(targets)
library(tarchetypes)
library(tibble)

# Source functions
source("R/functions.R")

# Define targets
tar_option_set(packages = c("shiny", "purrr"), error = "continue")

# Create the demo datasets
datasets <- create_demo_datasets(
  dataset_list = list(
    a = data.frame(param1 = c(1, 2), param2 = c(10, 12)),
    b = data.frame(param1 = c(3, 4), param2 = c(13, 14))#,
    # c = "wrong input"#,
    # d = data.frame(param1 = c(5, 6), param2 = c(15, 16)),
    # e = data.frame(param1 = c(7, 8, 9), param2 = c(17, 18, 19))
    # ... you can add more datasets
  )
)

data_names <- list("a" = "a", "b" = "b")
# Static branching
list(
  tar_map(
    values = data_names,
    names = "data_names",
    tar_target(result, test_server_fn(data_names))
  )
)

# list(
#   tar_map(
#     values = datasets,
#     names = "dataset_name",
#     tar_target(result, test_server_fn(
#       # datasets$dataset[[dataset_name]]
#       dataset[[dataset_name]]
#     ))
#   )
# )

# list(
#   tar_map(
#     values = datasets,
#     names = "dataset_name",
#     tar_target(result, test_server_fn(dataset))
#   )
# )
# 
# datasets <- tibble::tibble(
#   name = c("a", "b"),
#   data = list(
#     a = list(param1 = c(1, 2), param2 = c(10, 12)), 
#     b = list(param1 = c(3, 4), param2 = c(13, 14))
#   )
# )

# list(
#   tar_map(
#     values = names,
#     # names = "name",
#     tar_target(result, test_server_fn(data[[names]]))
#   )
# )