

#' Draw a bar plot with variable widths
#' 
#' @param data to be plotted
#' @param xname variable name for x axis (and widths)
#' @param yname variable name for y axis (and heights)
#' @param fillname variable name for fill colors
#' @param gap_fixed a fixed gap width (in units of x)
#' 
#' The standard ggplot2::geom_bar/geom_col has a width argument, but this argument does not affect the placement of the bars, so they quickly overlap. In addition, no x axis is displayed.
#' 
#' @import ggplot2
#' @import rlang
#' @import dplyr
area_bar_plot <- function(data, xname, yname, fillname, gap_fixed = 1) {
  
  xname <- rlang::enquo(xname)
  yname <- rlang::enquo(yname)
  fillname <- rlang::enquo(fillname)
  
  data2 <- data %>%
    mutate(gap = gap_fixed) %>%
    mutate(cum_gap = cumsum(lag(gap, default = 0))) %>%
    mutate(xmin = 
             cumsum(lag(!!xname, default = 0)) + cum_gap,
           xmax = cumsum(!!xname) + cum_gap)
  
  ggplot(data2, 
         aes(xmin = xmin,
             xmax = xmax, 
             ymin = 0,
             ymax = !!yname, 
             fill = !!fillname)) +
    geom_rect()
  
}