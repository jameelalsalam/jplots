# read in ex data

library(tidyverse)

ei_ex <- readr::read_csv("data-raw/ei_final.csv") %>%
  head() %>%
  select(naics, NAICSTitle, vos, ei) %>%
  mutate(ei = round(ei * 100, 2),
         vos = round(vos / 10^6, 2))

usethis::use_data(ei_ex)
