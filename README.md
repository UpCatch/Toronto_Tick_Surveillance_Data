# Blacklegged Ticks in Toronto Parks Are Concentrated in the East

## Overview

This paper examines where blacklegged ticks, which carry the bacterium that 
causes Lyme disease, are found in Toronto's parks using Toronto Public Health's
tick surveillance data from 2013 to 2023. Most surveyed parks recorded no ticks,
while a small group of sites in the Rouge Valley, in the city's northeast,
accounted for most of the ticks collected and most of those carrying infection.
The paper also shows that the apparent rise in infected ticks over time reflects
where ticks were caught each year rather than a change across the whole city,
and discusses what the surveillance program can and cannot say about Lyme disease
risk and climate change.

The data comes from the [Blacklegged Tick Surveillance](https://open.toronto.ca/dataset/blacklegged-tick-surveillance/)
dataset on Open Data Toronto, and the map uses the City's [Regional Municipal Boundary]
(https://open.toronto.ca/dataset/regional-municipal-boundary/). Both are downloaded
with the `opendatatoronto` R package. The analysis is done in R, and the paper is
written in Quarto and rendered to PDF.

## File Structure

The repo is structured as:

-   `data/01-raw_data` contains the raw tick surveillance data and the Toronto
boundary file as downloaded from Open Data Toronto, and the simulated dataset.
-   `data/02-analysis_data` contains the cleaned dataset used in the paper.
-   `other/llm` contains the full chat histories with the LLMs used in this project.
-   `other/sketches` contains sketches of the planned dataset and graphs.
-   `paper` contains the files used to generate the paper, including the Quarto
    document, the reference bibliography file, and the PDF of the paper.
-   `scripts` contains the R scripts used to simulate, test, download and clean the data.

## Reproducing the Paper

1. Clone this repository and open the `.Rproj` file in RStudio.
2. Install the required packages: `tidyverse`, `opendatatoronto`, `sf`, `here`, `tinytable` and `testthat`.
3. Run the scripts in `scripts/` in order:
    - `00-simulate_data.R` simulates the dataset.
    - `01-test_simulated_data.R` tests the simulated data.
    - `02-download_data.R` downloads the tick data and the Toronto boundary and saves them to `data/01-raw_data`.
    - `03-clean_data.R` cleans the raw data and saves it to `data/02-analysis_data`.
    - `04-test_analysis_data.R` tests the cleaned data.
4. Open `paper/paper.qmd` and render it to PDF.

Open Data Toronto is public, so no API key or account is needed. 
The paper reads only the saved data files and does not download anything itself.

## Statement on LLM Usage

Google Gemini was used in this project in parts of the data analysis process
and for debugging parts of the code. All output was reviewed, tested and edited by the author.
Grammarly was used to make final touches to the paper. 
The entire chat histories are available in `other/llm/usage.txt`.
