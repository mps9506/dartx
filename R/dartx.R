
#' Applies Correction Factor to Drainage Area Ratio Calculated Streamflows
#'
#' Streamflows estimated using the drainage-area ratio method are typically over-
#' or under-estimated at the tails of the streamflow distribution. Asquith,
#' Roussel, and Vrabel (2006) provide empirically-derived correction
#' factors for estimating streamflows in Texas using the drainage-area ratio
#' method. Applying this function to a dataframe of streamflows will return
#' a dataframe with the original streamflow, the non-exceedance probability
#' (cume_dist), the correction factor used (exp), and the estimated streamflow (Q).
#' @param .data table of class data.frame with at least one column with
#'   streamflows
#' @param flow Variable specifying streamflows in df
#' @param dar numeric, drainage area ratio to be applied
#' @param defaultPhi logical. Defaults to \code{TRUE}. Use \code{TRUE} to apply
#'   values reccomended by Asquith et. al. If \code{FALSE} provide a dataframe
#'   with derived values of phi as a dataframe with the following variables:
#'   \code{min}, \code{max}, \code{exp}. Where min and max are the range of
#'   percentile values to apply the value of phi and exp is the value of phi to
#'   be applied.
#' @param ... optional arguments. If \code{defaultPhi = TRUE}, expects a
#'   dataframe supplied for the argument \code{customPhi}.
#'
#' @return dataframe with new variables: cume_dist, exp and Q. Where cume_dist
#'  are the non-exceedance probability, exp are the values of phi applied to the
#'  DAR calculation and Q is the DAR estimated flow value.
#' @import dplyr
#' @export
#' @details The drainage area ratio is an algebraic method for estimating same-day
#'   streamflows from one location to another on the basis the the ratio of the
#'   drainage areas are the same as the ratio of the streamflow. The typical
#'   equation is:
#'   \deqn{Y = X\left ( \frac{A_y}{A_x} \right )^{\phi}}{Y = X(Ay/Ax)^phi}
#'   Where \eqn{Y} is the streamflow at the ungaged site, \eqn{X} is the streamflow
#'   at the gaged site, \eqn{A_y}{Ay} and \eqn{A_x}{Ax} are drainage areas of
#'   \eqn{Y} and \eqn{X}. Often, \eqn{\phi}{phi} is assumed equal to one.
#'
#'   Asquith, Roussel, and Vrabel (2006) developed empirically derived values
#'   of \eqn{\phi}{phi} based on streamflow percentiles (non-exceedance probability)
#'   for 54 percentiles of daily mean streamflow in Texas. Values of
#'   \eqn{\phi}{phi} range from 0.700 to 0.935.
#' @references Asquith, William H., Meghan C. Roussel, and Joseph Vrabel. 2006.
#'   “Statewide Analysis of the Drainage-Area Ratio Method for 34 Streamflow
#'   Percentile Ranges in Texas.” 2006–5286. U.S. Geological Survey Scientfic
#'   Investigations Report. U.S. Geological Survey.
#'   \url{https://pubs.usgs.gov/sir/2006/5286/pdf/sir2006-5286.pdf}.

dartx <- function(.data, flow, dar, defaultPhi = TRUE, ...) {

  flow <- rlang::enquo(flow)

  dots <- rlang::list2(...)

  if (is.data.frame(.data) == FALSE) {
    stop("df must be a data.frame")
  }

  if (is.numeric(dar) == FALSE) {
    stop("dar must be numeric")
  }

  .data <- .data %>%
    arrange(!! flow) %>%
    mutate(cume_dist = 1 - lmomco::pp(!! flow))

  if (defaultPhi) {
    .data <- phi(.data)
  }

  else {
    print(names(dots))

    if (!("customPhi" %in% names(dots))) {
      stop("When defaultPhi = FALSE, specify a dataframe for the optional argument customPhi that provides min, max and exp values for the expected streamflow percentiles and cooresponding values of phi applied to the drainage area ratio")
    }

    if (is.data.frame(dots$customPhi) == FALSE) {
      stop("customPhi must be a dataframe with the following columns: min, max, exp")
    }
    customPhi = dots$customPhi
    .data <- phi(.data, defaultPhi = FALSE, customPhi = customPhi)
  }

  .data <- .data %>%
    mutate(Q = Flow * (dar^exp)) %>%
    select(-min, -max)

  return(.data)
}


#' Estimate Values of Phi
#'
#' @param df dataframe with a column cume_dist
#' @param ... optional argument customPhi. Where customPhi is a dataframe with min, max, exp. Specifying the streamflow percentiles to apply values of phi (exp).
#'
#' @return dataframe
#' @import fuzzyjoin
#' @export
#'
#' @keywords internal
phi <- function(df, defaultPhi = TRUE, ...) {

  dots <- rlang::list2(...)

  if (defaultPhi) {
    Phi <- suggestedPhi
  }

  else {
    Phi = dots$customPhi
  }

  df <- df %>%
    fuzzyjoin::fuzzy_left_join(Phi, by = c("cume_dist" = "min",
                                                    "cume_dist" = "max"),
                               match_fun = list(`>=`, `<`))

  return(df)


}
