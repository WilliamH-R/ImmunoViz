
<!-- README.md is generated from README.Rmd. Please edit that file -->

# ImmunoViz

<!-- badges: start -->
<!-- badges: end -->

## Overview

Contains the Shiny framework around the functions for handling a large database of TCR sequences. The package containing the functions is called `ImmunoCleaner` and can be found [here](https://github.com/WilliamH-R/ImmunoCleaner). Information regarding the included functions and available data sets are also located in the package in the form of documentations, README, a technical report and a vignette.

The app is able to let the user freely pick between four data set at any time. The data sets are from different donors. Otherwise, they follow the same structure, and undergo the same preparation. Further, the user is able to select between a series of filters. When changing the filters, the visualisations are not changed until the button "Update data" have been clicked.

Biological data can be messy, and setting a ground truth as to when a TCR-pMHC interaction can be trusted is not feasible. Hence the need of data exploration. The goal is to keep as much data as possible, but only the data which is trusted. Different filters can be applied to the data sets, and the filtered data is visualised. The user can then freely choose between filters until some satisfactory outcome is reached.

A table showing the percentage of data points left compared to a baseline is always present. Further, four tabs are available in the app. The first tab shows some descriptive stats such as comparing count of relevant interactions pr. allele. The second tab include data checks such as a HLA-matching. The third tab is the actual data exploration. Lastly is a short README on how to use the app which also includes a table of the haplotype of each donor.

## Availability

Downloaded from GitHub:

``` r
devtools::install_github("WilliamH-R/ImmunoCleaner")
```
Run the script `dev/run_dev.R`
