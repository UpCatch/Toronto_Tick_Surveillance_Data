#### Preamble ####
# Purpose: Tests the cleaned data from OpenDataToronto's blacklegged tick
# surveillance data
# Author: Shrey Sati
# Date: 26 September 2026
# Contact: shrey.sati@mail.utoronto.ca
# License: MIT
# Pre-requisites:
# - 03-clean_data.R has run
# - data/02-analysis_data/analysis_data.csv exists
# - testthat and here packages are installed
# Any other information needed? N/A


#### Workspace setup ####
library(tidyverse)
library(testthat)
library(here)

# Test if the data file exists and can be loaded
test_that("cleaned data file loads properly", {
  expect_true(file.exists(here("data/02-analysis_data/analysis_data.csv")))
})

cleaned_data <- read_csv(here("data/02-analysis_data/analysis_data.csv"))


#### Test data structure and contents ####

test_that("dataset dimensions are correct", {
  expect_equal(nrow(cleaned_data), 233)
  expect_equal(ncol(cleaned_data), 9)
})

test_that("'id' is unique and in strictly increasing sequential order", {
  expect_equal(cleaned_data$id, 1:233)
})

test_that("the 'year' column contains only valid surveillance years", {
  valid_years <- c(2013:2019, 2023)
  expect_true(all(cleaned_data$year %in% valid_years))
})

test_that("'park_locations' contains no missing or blank values", {
  expect_false(any(is.na(cleaned_data$park_locations)))
  expect_false(any(cleaned_data$park_locations == ""))
})

test_that("'total_blts' matches 'blt_adults_and_nymphs'", {
  expect_identical(cleaned_data$total_blts, cleaned_data$blt_adults_and_nymphs)
})

test_that("'num_positive' is never greater than 'blt_adults_and_nymphs'", {
  expect_true(all(cleaned_data$num_positive <= cleaned_data$blt_adults_and_nymphs))
})

test_that("coordinates fall within the expected geographic bounding box", {
  # Check latitude boundaries (43.55 to 43.87), with some padding
  expect_true(all(cleaned_data$latitude >= 43.55 & cleaned_data$latitude <= 43.87))

  # Check longitude boundaries (-79.65 to -79.10), with some padding
  expect_true(all(cleaned_data$longitude >= -79.65 & cleaned_data$longitude <= -79.10))
})
