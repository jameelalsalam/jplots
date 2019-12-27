#' Variable width bars
#' 
#' Create bar charts with meaningful heights (using the y aesthetic) and widths (using the x aesthetic). Bars are presented with no gaps in between so that the x-axis is meaningful.
#'
#' @inheritParams ggplot2::geom_bar
#' @export
geom_area_bar <- function(mapping = NULL, data = NULL,
                     position = "identity",
                     ...,
                     na.rm = FALSE,
                     show.legend = NA,
                     inherit.aes = TRUE) {
  
  layer(
    data = data,
    mapping = mapping,
    stat = StatAreaBar,
    geom = GeomAreaBar,
    position = position,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = list(
      na.rm = na.rm,
      ...
    )
  )
}

#' @rdname geom_area_bar
#' @format NULL
#' @usage NULL
#' @export
GeomAreaBar <- ggproto("GeomAreaBar", GeomRect,
                   required_aes = c("xmin", "xmax", "ymin", "ymax")
                   #,
                   
                   # These aes columns are created by setup_data(). They need to be listed here so
                   # that GeomRect$handle_na() properly removes any bars that fall outside the defined
                   # limits, not just those for which x and y are outside the limits
                   #non_missing_aes = c("xmin", "xmax", "ymin", "ymax")
                   #,
                   
                   # setup_data = function(data, params) {
                   #   data$width <- data$width %||%
                   #     params$width %||% (resolution(data$x, FALSE) * 0.9)
                   #   transform(data,
                   #             ymin = pmin(y, 0), ymax = pmax(y, 0),
                   #             xmin = cumsum(dplyr::lag(x, default = 0)), 
                   #             xmax = cumsum(x), width = NULL
                   #   )
                   # },
                   # 
                   # draw_panel = function(self, data, panel_params, coord, width = NULL) {
                   #   # Hack to ensure that width is detected as a parameter
                   #   ggproto_parent(GeomRect, self)$draw_panel(data, panel_params, coord)
                   # }
)

#' @rdname geom_area_bar
#' @format NULL
#' @usage NULL
#' @export
StatAreaBar <- ggproto("StatAreaBar", Stat,
  compute_panel = function(data, scales) {
    data <- data %>%
      mutate(
        ymin = pmin(y, 0),
        ymax = pmax(y, 0),
        xmin = cumsum(dplyr::lag(x, default = 0)), 
        xmax = cumsum(x)
      ) %>%
      select(-x, -y)
  },
  required_aes = c("x", "y")
)

