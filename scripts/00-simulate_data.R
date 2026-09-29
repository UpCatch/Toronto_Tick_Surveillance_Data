#### Preamble ####
# Purpose: Simulate  Toronto's tick surveillance data from 2013-2023
# Author: Shrey Sati
# Date: 26 September 2026
# Contact: shrey.sati@mail.utoronto.ca
# License: MIT
# Pre-requisites: None
# Any other information needed? N/A


#### Workspace setup ####
library(tidyverse)
set.seed(853)


#### Simulate data ####

# Number of observations in the dataset
num_observations <- 233

# Toronto Public Health (TPH) visits the same list of sites each year
# Simulates a pool of 26 park locations
park_locations <- paste("Park", LETTERS[1:26])

# Tick surveillance was paused from 2020-2022 due to COVID
# Simulate the gap in surveillance data
years <- c(2013:2019, 2023)


simulated_data <-
  tibble(
    id = 1:num_observations,
    park_locations = sample(park_locations, size = num_observations, replace = TRUE),
    year = sample(years, size = num_observations, replace = TRUE),
    # Approximately 76% of tick drags find 0 ticks
    found_ticks = rbinom(num_observations, size = 1, prob = 0.24),
    blt_adults_and_nymphs = if_else(
      found_ticks == 1,
      rpois(num_observations, lambda = 10.6),
      0L
    ),
    # Larvae are almost never found (1.7% chance) and are not
    # included in Total BLTs count
    blt_larvae = rbinom(num_observations, size = 1, prob = 0.017) *
      sample(1:9, size = num_observations, replace = TRUE),
    # Total BLTs is always equal to Adults and Nymphs value in the data
    total_blts = blt_adults_and_nymphs,
    num_positive = rbinom(
      num_observations,
      size = blt_adults_and_nymphs,
      prob = 0.35
    ),
    latitude = round(runif(num_observations, min = 43.6, max = 43.8), 6),
    longitude = round(runif(num_observations, min = -79.6, max = -79.1), 6)
  ) |>
  select(-found_ticks)

#### Save data ####
write_csv(simulated_data, file = "data/00-simulated_data/simulated_data.csv")
