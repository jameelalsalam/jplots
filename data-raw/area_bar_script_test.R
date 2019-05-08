

library(tidyverse)

# attempt 1
ggplot(ei_ex, 
       aes(x = factor(naics), y = ei, width =  vos, fill = naics)) +
  geom_bar(stat = "identity",
           position = position_dodge2(preserve = "single",
                                      padding = 0))

# attempt 2
ggplot(ei_ex, 
       aes(xmin = 0,
           xmax = vos, 
           ymin = 0,
           ymax = ei, 
           fill = naics)) +
  geom_rect() +
  facet_grid(. ~ naics, space = "free_x", scales = "free_x")

# attempt 3
ei_ex2 <- ei_ex %>%
  mutate(gap = 1) %>%
  mutate(cum_gap = cumsum(lag(gap, default = 0))) %>%
  mutate(xmin = 
           cumsum(lag(vos, default = 0)) + cum_gap,
         xmax = cumsum(vos) + cum_gap)
  
ggplot(ei_ex2, 
         aes(xmin = xmin,
             xmax = xmax, 
             ymin = 0,
             ymax = ei, 
             fill = naics)) +
  geom_rect()


library(tidyverse)
devtools::load_all(".")
area_bar_plot(ei_ex, xname = vos, yname = ei, fillname = naics)


