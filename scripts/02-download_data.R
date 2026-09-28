#### Preamble ####
# Purpose: Downloads and saves the Blacklegged Tick surveillance data 
# from Open Data Toronto
# Author: Shrey Sati
# Date: 26 September 2026
# Contact: shrey.sati@mail.utoronto.ca
# License: MIT
# Pre-requisites: 
  # - The `opendatatoronto`, 'dplyr', and 'readr' packages must be installed and loaded
# Any other information needed? N/A


#### Workspace setup ####
library(opendatatoronto)
library(dplyr)
library(readr)

# Get all resources for this package
resources <- list_package_resources("78c88292-5375-4373-a687-788a5ff19077")

# Identify datastore resources
datastore_resources <- filter(resources, tolower(format) %in% c('csv', 'geojson'))

raw_data <-
  resources |>
  filter(name == "BLT Active Surveillance Results") |>
  get_resource()

#### Save data ####
write_csv(raw_data, file = "data/01-raw_data/raw_data.csv")
         
