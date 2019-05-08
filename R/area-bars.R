# Various attempts to make a bar graph with specified widths, on top of ggplot2

#' Area bars
#' 
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