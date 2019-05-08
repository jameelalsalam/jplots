# envelope-plot


#' @export
envelope_fig <- function(data, xname, yname, groupname, facetname) {
  
  figdat <- data
  
  xname <- enquo(xname)
  yname <- enquo(yname)
  groupname <- enquo(groupname)
  facetname <- enquo(facetname)
  
  figdat_envelope <- data %>%
    dplyr::group_by(!!facetname, !!xname) %>%
    dplyr::summarize(var_min    =    min(!!yname, na.rm = TRUE),
                     var_max    =    max(!!yname, na.rm = TRUE),
                     var_mean   =   mean(!!yname, na.rm = TRUE),
                     var_median = median(!!yname, na.rm = TRUE)) %>% 
    dplyr::ungroup()
  
  
  result <- ggplot(mapping = aes(x=!!xname)) + 
    facet_grid(cols = vars(!!facetname)) +
    
    geom_ribbon(data = figdat_envelope, show.legend = FALSE,
                mapping = aes(ymin = var_min, ymax = var_max), 
                fill = "lightblue", alpha = 0.5) +
    
    geom_line(data = figdat, 
             mapping = aes(group = !!groupname, y = !!yname),
             color = "lightblue") +
    
    geom_line(data = figdat_envelope, 
              mapping = aes(y = var_mean),
              color = "coral2") +
    
    geom_line(data = figdat_envelope, 
              mapping = aes(y = var_median),
              color = "limegreen")
  
  result
}

