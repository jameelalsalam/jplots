#' Envelopes around groups of lines
#' 
#' @inheritParams ggplot2::geom_line
#' @export
geom_envelope <- function(mapping = NULL, data = NULL, stat = "identity",
                      position = "stack", na.rm = FALSE, show.legend = NA,
                      inherit.aes = TRUE, ...) {
  layer(
    data = data,
    mapping = mapping,
    stat = stat,
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
GeomArea <- ggproto("GeomEnvelope", GeomRibbon,
                    default_aes = aes(colour = NA, fill = "grey20", size = 0.5, linetype = 1,
                                      alpha = NA),
                    
                    required_aes = c("x", "y"),
                    
                    setup_data = function(data, params) {
                      transform(data[order(data$PANEL, data$group, data$x), ], ymin = 0, ymax = y)
                    }
)