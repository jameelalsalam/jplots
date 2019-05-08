

aeo_ex <- readr::read_csv("data-raw/AEO2019_CO2_by_Fuel_USregion.csv") %>%
  select(fuel, scenario, year = Year, emissions = value) %>%
  mutate(scenario = str_remove(scenario, " MMmt CO2$")) %>%
  filter(! fuel %in% c("Other", "Total"))

usethis::use_data(aeo_ex, overwrite = TRUE)
