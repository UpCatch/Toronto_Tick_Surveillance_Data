#### Preamble ####
# Purpose: Cleans the raw Blacklegged Tick surveillance data from OpenDataToronto
# Author: Shrey Sati
# Date: 26 September 2026
# Contact: shrey.sati@mail.utoronto.ca
# License: MIT
# Pre-requisites:
# - 02-download_data.R has been run
# - data/01-raw_data/raw_data.csv exists
# Any other information needed? N/A

#### Workspace setup ####
library(tidyverse)

#### Clean data ####
raw_data <- read_csv("data/01-raw_data/raw_data.csv")

# The 'geometry' column contains strings that look like
# {"type": "Point", "coordinates": [-79.360567, 43.62612]}
# Use regex to extract the latitude and longitude values from the string
pattern <- "\\[\\s*(-?\\d+\\.\\d+)\\s*,\\s*(-?\\d+\\.\\d+)\\s*\\]"
coordinates <- str_match(
  raw_data$geometry, pattern
)

cleaned_data <-
  raw_data |>
  # Turn the latitudes and longitudes from str_match() into numbers
  mutate(
    longitude = as.numeric(coordinates[, 2]),
    latitude = as.numeric(coordinates[, 3])
  ) |>
  # Rename the columns so that they are more human-readable
  rename(
    id = `_id`,
    park_locations = `Park Location`,
    total_blts = `Total BLTs`,
    blt_larvae = `BLT Larvae`,
    blt_adults_and_nymphs = `BLT Adults and Nymphs`,
    num_positive = `# Positive`,
    year = Year
  ) |>
  # Keep only necessary columns.
  # 'geometry' column can be dropped since latitude and longitude have been extracted
  select(
    id, park_locations, year, blt_larvae, blt_adults_and_nymphs, total_blts,
    num_positive, latitude, longitude
  ) |>
  # Ensure cell values are whole numbers
  mutate(
    year = as.integer(year),
    blt_larvae = as.integer(blt_larvae),
    blt_adults_and_nymphs = as.integer(blt_adults_and_nymphs),
    total_blts = as.integer(total_blts),
    num_positive = as.integer(num_positive)
  )

#### Save data ####
write_csv(cleaned_data, "data/02-analysis_data/analysis_data.csv")
