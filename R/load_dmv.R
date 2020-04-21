### This reads in the Johns Hopkins data for the Washington Metropolitan 
### Statistical Area as defined by the US Census. The data is filtered
### and exported as two geoJSON files.

library(tidyverse)
library(sf)

dmv_data <- st_read("https://github.com/Slushmier/covid_us_tidy_time_series/raw/master/Data/counties_all.geojson") %>% 
  dplyr::filter(STNAME == "Virginia" | STNAME == "Maryland" | 
                  STNAME == "West Virginia" | STNAME == "District of Columbia") %>% 
  dplyr::filter(NAMELSA %in% 
                  c("District of Columbia", "Calvert County", "Charles County",
                    "Frederick County", "Prince George's County",
                    "Jefferson County", "Montgomery County", "Alexandria city",
                    "Arlington County",
                    "Clarke County", "Culpeper County", "Fairfax County", 
                    "Fairfax city", "Falls Church city", "Fauquier County",
                    "Fredericksburg city", "Loudoun County", "Manassas city",
                    "Manassas Park city", "Prince William County", 
                    "Rappahannock County", "Spotsylvania County", 
                    "Stafford County", "Warren County")) %>% 
  dplyr::filter(!(STNAME == "Virginia" & NAMELSA %in%
                  c("Montgomery County", "Frederick County"))) %>% 
  dplyr::select(-date, -Province_State, -Country_Region, -Confirmed, -Deaths, 
                -Recovered, -Active, -Combined_Key) %>% 
  dplyr::mutate(GEOID = as.numeric(as.character(GEOID)))

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
