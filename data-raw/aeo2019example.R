# Step 1: downloaded xlsx -> csv file

library(dplyr)
library(tidyr)
library(readxl)


a <- read_xlsx('AEO2019_CO2_Total_by_Fuel_US.xlsx') %>%
  gather(fuelscenario, "value",
         "Petroleum: Reference case MMmt CO2",
         "Petroleum: High economic growth MMmt CO2",
         "Petroleum: Low economic growth MMmt CO2",
         "Petroleum: High oil price MMmt CO2",
         "Petroleum: Low oil price MMmt CO2",
         "Petroleum: High oil and gas resource and technology MMmt CO2",
         "Petroleum: Low oil and gas resource and technology MMmt CO2",
         "Petroleum: AEO2018 without Clean Power Plan MMmt CO2",
         "Natural Gas: Reference case MMmt CO2",
         "Natural Gas: High economic growth MMmt CO2",
         "Natural Gas: Low economic growth MMmt CO2",
         "Natural Gas: High oil price MMmt CO2",
         "Natural Gas: Low oil price MMmt CO2",
         "Natural Gas: High oil and gas resource and technology MMmt CO2",
         "Natural Gas: Low oil and gas resource and technology MMmt CO2",
         "Natural Gas: AEO2018 without Clean Power Plan MMmt CO2",
         "Coal: Reference case MMmt CO2",
         "Coal: High economic growth MMmt CO2",
         "Coal: Low economic growth MMmt CO2",
         "Coal: High oil price MMmt CO2",
         "Coal: Low oil price MMmt CO2",
         "Coal: High oil and gas resource and technology MMmt CO2",
         "Coal: Low oil and gas resource and technology MMmt CO2",
         "Coal: AEO2018 without Clean Power Plan MMmt CO2",
         "Other: Reference case MMmt CO2",
         "Other: High economic growth MMmt CO2",
         "Other: Low economic growth MMmt CO2",
         "Other: High oil price MMmt CO2",
         "Other: Low oil price MMmt CO2",
         "Other: High oil and gas resource and technology MMmt CO2",
         "Other: Low oil and gas resource and technology MMmt CO2",
         "Other: AEO2018 without Clean Power Plan MMmt CO2",
         "Total: Reference case MMmt CO2",
         "Total: High economic growth MMmt CO2",
         "Total: Low economic growth MMmt CO2",
         "Total: High oil price MMmt CO2",
         "Total: Low oil price MMmt CO2",
         "Total: High oil and gas resource and technology MMmt CO2",
         "Total: Low oil and gas resource and technology MMmt CO2",
         "Total: AEO2018 without Clean Power Plan MMmt CO2") %>%
  separate(fuelscenario, c("fuel", "scenario"), sep = ": ") %>%
  write.csv("AEO2019_CO2_by_Fuel_USregion.csv", row.names = FALSE)








