# read in ex data

library(tidyverse)

ei_ex <- readr::read_csv(
  "data-raw/ei_final.csv",
  col_types = cols(
    naics = col_character(),
    NAICSTitle = col_character(),
    vos = col_double(),
    emp = col_double(),
    estab = col_double(),
    ei = col_double(),
    energy = col_double()
  )) %>%
  head() %>%
  select(naics, NAICSTitle, vos, ei) %>%
  mutate(ei = round(ei * 100, 2),
         vos = round(vos / 10^6, 2))

usethis::use_data(ei_ex, overwrite = TRUE)
