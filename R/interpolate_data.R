#' Interpolation in a dataframe
#' 
#' Plotting envelopes or computing min/max/percentile statistics over a time series requires that the same year intervals be used in each series. This function is intended to fill in intermediate values through interpolation, in the context of a completed data frame, where NA valeus represent values to be filled.
#' 
#' This function is an awkward fit for this package, but I didn't know where to put it!
#' 
#' The additional variable specifications, result_var and interp_var, can be useful for debugging because they provide the constituent detailed data.
#' 
#'@param data within which to interpolate
#'@param x_var
#'@param y_var string or symbol of the value variable being interpolated
#'@param by_vars character vector of variables that define grouping
#'
#'@import dplyr
#'@import tidyr
#'
#'@export
interpolate_data <- function(.data, x_var, y_var, result_var, interp_var, by_vars) {
  
  # currently all required.
  # TODO: add back result_var and interp_var?
  x_var <- rlang::ensym(x_var)
  y_var <- rlang::ensym(y_var)
  by_vars   <- rlang::syms(by_vars)
  
  
  #Complete the implicit missing years/values
  data_complete_w_na <- .data %>%
    tidyr::complete(nesting(!!!by_vars), !!x_var) %>%
    arrange(!!!by_vars, !!x_var) # does approx need ordered?
  
  ### INTERPOLATION SECTION
  
  #This section performs linear interpolation.
  #It takes as input data frames which are already "completed" with the NA values that will be filled in through interpolation.
  #Apply the interpolation function to the entire dataset (only within data NAs are interpolated, outside core data.
  #NAs are returned as NAs.
  
  data_interpolated <- data_complete_w_na %>%
    group_by(!!!by_vars) %>%
    nest() %>%
    mutate(int_pts = map(data,
                         .f = ~ safe_approx(x=.[[x_var]], y=.[[y_var]], xout = .[[x_var]]) )) %>%
    mutate(int_pts = map(int_pts,
                         ~select(.x, !!y_var := y,
                                 ))) %>%
    mutate(data = map(data, ~select(.x, -!! y_var))) %>%
    
    unnest(cols = c(data, int_pts)) %>%
    
    select(!!!by_vars, !!x_var, !!y_var)
  
  data_interpolated
}

#wraps the approx call, checking to see if there are multiple points to interpolate or not

safe_approx <- function(x, y, xout) {
  
  if(sum(!is.na(x) & !is.na(y)) > 1) {
    approx(x, y, xout) %>% as_tibble()
  } else {
    tibble(x=x, y=y)
  }
  
}
