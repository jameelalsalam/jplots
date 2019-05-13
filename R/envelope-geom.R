#' Envelopes around groups of lines
#' 
#' @inheritParams ggplot2::geom_line
#' @export
geom_envelope <- function(mapping = NULL, data = NULL, stat = "identity",
                      position = "identity", na.rm = FALSE, show.legend = NA,
                      inherit.aes = TRUE, ...) {
  layer(
    data = data,
    mapping = mapping,
    stat = StatEnvelope,
    geom = GeomEnvelope,
    position = position,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = list(
      na.rm = na.rm,
      ...
    )
  )
}

#' @rdname geom_envelope
#' @format NULL
#' @usage NULL
#' @export
GeomEnvelope <- ggproto("GeomEnvelope", GeomRibbon,
                    default_aes = aes(colour = NA, fill = "grey20", size = 0.5, linetype = 1,
                                      alpha = 0.2),
                    
                    required_aes = c("x", "ymin", "ymax")
                    # ,
                    # 
                    # setup_data = function(data, params) {
                    #   transform(data[order(data$PANEL, data$group, data$x), ], ymin = 0, ymax = y)
                    # }
)


#' @export
stat_envelope <- function(mapping = NULL, data = NULL, geom = "ribbon",
                                     position = "identity", na.rm = FALSE, show.legend = NA, 
                                     inherit.aes = TRUE, ...) {
  layer(
    stat = StatEnvelope, data = data, mapping = mapping, geom = geom, 
    position = position, show.legend = show.legend, inherit.aes = inherit.aes,
    params = list(na.rm = na.rm, ...)
  )
}


#' @export
StatEnvelope <- ggproto("StatEnvelope", Stat,
                        compute_group = function(data, scales) {
                          data %>%
                            group_by(x) %>%
                            summarize(
                              ymin = min(y),
                              ymax = max(y)
                            )
                        },
                        required_aes = c("x", "y")
                        )





