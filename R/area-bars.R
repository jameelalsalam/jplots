# Various attempts to make a bar graph with specified widths, on top of ggplot2

#' Area bars
#' @import ggplot2
#' @import rlang
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


#' @export
geom_area_bar <- function(mapping = NULL, data = NULL,
                     position = "stack",
                     ...,
                     width = NULL,
                     na.rm = FALSE,
                     show.legend = NA,
                     inherit.aes = TRUE) {
  
  layer(
    data = data,
    mapping = mapping,
    stat = "identity",
    geom = GeomAreaBar,
    position = position,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = list(
      width = width,
      na.rm = na.rm,
      ...
    )
  )
}

#' @format NULL
#' @usage NULL
#' @export
GeomAreaBar <- ggproto("GeomAreaBar", GeomRect,
                   required_aes = c("x", "y"),
                   
                   # These aes columns are created by setup_data(). They need to be listed here so
                   # that GeomRect$handle_na() properly removes any bars that fall outside the defined
                   # limits, not just those for which x and y are outside the limits
                   non_missing_aes = c("xmin", "xmax", "ymin", "ymax"),
                   
                   setup_data = function(data, params) {
                     data$width <- data$width %||%
                       params$width %||% (resolution(data$x, FALSE) * 0.9)
                     transform(data,
                               ymin = pmin(y, 0), ymax = pmax(y, 0),
                               xmin = cumsum(dplyr::lag(x, default = 0)), 
                               xmax = cumsum(x), width = NULL
                     )
                   },
                   
                   draw_panel = function(self, data, panel_params, coord, width = NULL) {
                     # Hack to ensure that width is detected as a parameter
                     ggproto_parent(GeomRect, self)$draw_panel(data, panel_params, coord)
                   }
)



