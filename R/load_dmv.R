### This reads in the Johns Hopkins data for the Washington Metropolitan 
### Statistical Area as defined by the US Census. The data is filtered
### and exported as two geoJSON files.

# Setting this to allow task scheduling
setwd("C://Users/Slushmier/Documents/GitHub/wash_metro_covid")

library(tidyverse)
library(sf)

dmv_data <- st_read("https://raw.githubusercontent.com/Slushmier/wash_metro_covid/main/Data/dmv_county_boundaries.geojson")

confirmed_timeseries <- st_read("https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_confirmed_US.csv") %>% 
  mutate(FIPS = as.numeric(as.character(FIPS)))
deaths_timeseries <- st_read("https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_deaths_US.csv") %>% 
  mutate(FIPS = as.numeric(as.character(FIPS)))

dmv_ts <- left_join(dmv_data, confirmed_timeseries, by = c("GEOID" = "FIPS")) %>% 
  dplyr::select(-Long_, -Combined_Key, -Lat, -Province_State, -UID, -iso2,
                -iso3, -code3, -Admin2, -case_rate, -Country_Region) %>% 
  pivot_longer(cols = starts_with("x"), names_to = "date", values_to = "Confirmed") %>% 
  mutate(date = str_remove_all(date, "[X]")) %>% 
  st_sf()

deaths_timeseries <- deaths_timeseries %>% 
  select(FIPS, starts_with("X")) %>% 
  pivot_longer(cols = starts_with("X"), names_to = "date", values_to = "Deaths") %>% 
  mutate(date = str_remove_all(date, "[X]"))


dmv_ts <- left_join(dmv_ts, deaths_timeseries, by = c("GEOID" = "FIPS", "date")) %>%
  mutate(date = as.Date(dmv_ts$date, format = "%m.%d.%y", tz = "UTC")) %>% 
  group_by(NAMELSA) %>% 
  mutate_at(c("Confirmed", "Deaths"), ~as.numeric(as.character(.x))) %>% 
  replace_na(list(Confirmed = 0, Deaths = 0)) %>% 
  mutate(Confirmed = if_else(Confirmed > lag(Confirmed), Confirmed, lag(Confirmed)))
  
dmv_ts$date <- as.Date(dmv_ts$date, format = "%m.%d.%y", tz = "UTC")

dmv_ts <- dmv_ts %>% group_by(NAMELSA) %>% 
  mutate(Confirmed = if_else(Confirmed > lag(Confirmed), Confirmed, lag(Confirmed)),
         Deaths = if_else(Deaths > lag(Deaths), Deaths, lag(Deaths))) %>% 
  replace_na(list(Confirmed = 0, Deaths = 0))

dmv_ts <- dmv_ts %>% 
  group_by(NAMELSA) %>%  
  dplyr::mutate(New_Confirmed = Confirmed - lag(Confirmed),
                New_Deaths = Deaths - lag(Deaths)) %>% 
  replace_na(list(New_Confirmed = 0, New_Deaths = 0)) %>% 
  dplyr::mutate(New_Confirmed = if_else(New_Confirmed < 0, 0, New_Confirmed),
                New_Deaths = if_else(New_Deaths < 0, 0, New_Deaths))
  
newest <- dmv_ts %>% dplyr::filter(date == max(date))

st_write(dmv_ts, "Data\\dmv_covid_spatial_timeseries.geojson", delete_dsn = T)
st_write(newest, "Data\\dmv_covid_newest_spatial.geojson", delete_dsn = T)
