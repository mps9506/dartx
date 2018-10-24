
<!-- README.md is generated from READOTHER.Rmd. Please edit that file -->

# dartx

**dartx** is an R package to facilitate applying correction factors to
streamflows calcualted with the Drainage Area Ratio Method (DAR).
**dartx** consists of a single function that calculates the streamflow
probability (the non-exceedance probability), identifies the appropriate
correction factor, and calculates the streamflow of an ungaged station
with a user provided drainage area ratio.

## Installation

You can install the the development version from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("mps9506/dartx")
```

Currently there are no plans to submit the package to CRAN.

## Background

The DAR method is a simple method to estimate streamflows with the
assumption that the relationship between streamflows at a gaged site and
an ungaged site are equivelent to the ratio of the drainage areas. In
practice this looks like:

<p align="center"><img src="https://rawgit.com/mps9506/dartx/master/svgs/7bee8dd92a301dd1298cc739537b9e82.svg?invert_in_darkmode" align=middle width=235.9719714pt height=18.88772655pt/></p>
