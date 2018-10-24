
<!-- README.md is generated from README.Rmd. Please edit that file -->

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

\[
Y = X \left (\frac{A_{y}}{A_{x}} \right)^\phi
\]
