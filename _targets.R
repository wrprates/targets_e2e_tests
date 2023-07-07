# _targets.R
library(targets)
library(tarchetypes)

# Source functions
tar_source()

# Define targets
tar_option_set(packages = c("shiny", "tibble"), error = "continue")

# Create the demo datasets
datasets <- create_demo_datasets(
  dataset_list = list(
    a = quote(data.frame(param1 = c(1, 2), param2 = c(10, 12))),
    b = quote(data.frame(param1 = c(3, 4), param2 = c(13, 14))),
    c = quote(data.frame(param1 = c(5, 6), param2 = c(15, 16))),
    d = "Wrong input.",
    e = quote(data.frame(param1 = c(7:10), param2 = c(17:20)))
    # ... you can add more datasets, try to add a string to force an error
    # see https://github.com/ropensci/tarchetypes/discussions/105 
    #. to understand the use of quote()
  )
)

# Static branching
list(
  tar_map(
    values = datasets,
    names = "dataset_name",
    tar_target(result, test_server_fn(dataset))
  )
)
