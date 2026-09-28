#### Preamble ####
# Purpose: Downloads and saves the Blacklegged Tick surveillance data 
# and the City of Toronto boundary from Open Data Toronto.
# Author: Shrey Sati
# Date: 26 September 2026
# Contact: shrey.sati@mail.utoronto.ca
# License: MIT
# Pre-requisites: 
# - The `opendatatoronto`, `dplyr`, `readr`, and `sf` packages must be installed and loaded
# Any other information needed? N/A


#### Workspace setup ####
library(opendatatoronto)
library(dplyr)
library(readr)
library(sf)

#### Download Blacklegged Tick Data ####

# Get all resources for this package
blt_resources <- list_package_resources("78c88292-5375-4373-a687-788a5ff19077")

raw_data <-
  blt_resources |>
  filter(name == "BLT Active Surveillance Results") |>
  get_resource()


#### Download Toronto Boundary Data ####
boundary_resources <- list_package_resources("841fb820-46d0-46ac-8dcb-d20f27e57bcc")

toronto_boundary <- 
  boundary_resources |> 
  filter(name == "toronto-boundary-wgs84") |> 
  get_resource()


#### Save data ####
# Save the BLT dataset
write_csv(raw_data, file = "data/01-raw_data/raw_data.csv")

# Save the Toronto boundary as a GeoPackage (overwriting if it already exists)
st_write(toronto_boundary, "data/01-raw_data/toronto_boundary.gpkg", delete_dsn = TRUE)