#' Exponent values for streamflow estimation
#'
#' Mean values of phi per quartile for stations < 100 miles apart and absolute
#' value of the logarithim of the ratio fo the drainage areas >= 0.25. Included
#' mainly to demonstrate how to use custom Phi values.
#'
#' @format A data frame with four rows and three variables:
#' \describe{
#'     \item{min}{minimum of the range of streamflow percentile values that exp is used for}
#'     \item{max}{minimum of the range of streamflow percentile values that exp is used for}
#'     \item{exp}{estimated values of the exponent parameter to apply to the drainage area ratio}}
#' @source Asquith, William H., Meghan C. Roussel, and Joseph Vrabel. 2006. “Statewide Analysis of the Drainage-Area Ratio Method for 34 Streamflow Percentile Ranges in Texas.” 2006–5286. U.S. Geological Survey Scientfic Investigations Report. U.S. Geological Survey.
"quartilePhi"
