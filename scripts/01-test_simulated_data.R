#### Preamble ####
# Purpose: Tests the simulated Toronto blacklegged tick (BLT) surveillance data 
# Author: Shrey Sati
# Date: 26 September 2026
# Contact: shrey.sati@mail.utoronto.ca
# License: MIT
# Pre-requisites: 
  # - The `tidyverse` package must be installed and loaded
  # - 00-simulate_data.R must have been run
# Any other information needed? N/A


#### Workspace setup ####
library(tidyverse)

simulated_data <- read_csv("data/00-simulated_data/simulated_data.csv")

# Test if the data was successfully loaded
if (exists("simulated_data")) {
  message("Test Passed: The dataset was successfully loaded.")
} else {
  stop("Test Failed: The dataset could not be loaded.")
}

#### Test data ####

# Check if dataset has 233 rows
if (nrow(simulated_data) == 233) {
  message("Test Passed: The dataset has 233 rows.")
} else {
  stop("Test Failed: The dataset does not have 233 rows.")
}

# Check if dataset has 9 columns
if (ncol(simulated_data) == 9) {
  message("Test Passed: The dataset has 9 columns.")
} else {
  stop("Test Failed: The dataset does not have 9 columns.")
}

# Check if every id is unique and in increasing order
if (all(simulated_data$id == 1:233)) {
  message("Test Passed: 'id' is unique and in increasing order.")
} else {
  stop("Test Failed: 'id' is not in increasing order.")
}

# Check if years are valid
are_years_valid <- c(2013:2019, 2023)

if (all(simulated_data$year %in% are_years_valid)) {
  message("Test Passed: The 'year' column only contained valid years.")
} else {
  stop("Test Failed: The 'year' column does not contain valid years.")
}

# Check if 'park_locations' contains no missing/blank values
if (all(!is.na(simulated_data$park_locations)) && all(simulated_data$park_locations != "")) {
  message("Test Passed: 'park_locations' contains no missing/blank values.")
} else {
  stop("Test Failed: 'park_locations' contains missing/blank values.")
}

# Check if 'total_blts' always equals 'blt_adults_and_nymphs'
if (all(simulated_data$total_blts == simulated_data$blt_adults_and_nymphs)) {
  message("Test Passed: 'total_blts' always equals 'blt_adults_and_nymphs'.")
} else {
  stop("Test Failed: 'total_blts' does not always equals 'blt_adults_and_nymphs'.")
}

# Check if 'num_positive' is never greater than 'blt_adults_and_nymphs'
if (all(simulated_data$num_positive <= simulated_data$blt_adults_and_nymphs)) {
  message("Test Passed: 'num_positive' is never greater than 'blt_adults_and_nymphs'.")
} else {
  stop("Test Failed: 'num_positive' is greater than 'blt_adults_and_nymphs' in at least one row.")
}