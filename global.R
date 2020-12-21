library(shiny)
library(shinydashboard)
library(lubridate)
library(dplyr)
library(stringr)
library(plotly)
library(ggplot2)
library(readr)
library(leaflet)
library(countrycode)
library(tidyr)
library(ggthemes)
library(rgdal)
library(maps)
library(ggmap)
library(shinythemes)

crop<-read_csv("Crop Production - 2019.csv")
crop<-crop %>% 
  select(-FREQUENCY,-`Flag Codes`)
iso_none<-crop %>% 
  filter(LOCATION %in% c("BRICS","WLD","OECD")) %>% 
  mutate(LOCATION=ifelse(LOCATION=="WLD","Worldwide",LOCATION))
crop$LOCATION<-countrycode(crop$LOCATION,"iso3c","country.name")
iso_yes<-crop %>% 
  drop_na()
glimpse(iso_yes)  
crop_cleaned<-rbind(iso_none,iso_yes)
crop_cleaned

wheat<-read_csv("Wheat.csv")
maize<-read_csv("Maize.csv")
rice<-read_csv("Rice.csv")
soybean<-read_csv("Soybean.csv")
wheat<-wheat %>% 
  select(-`Flag Codes`,-FREQUENCY)
maize<-maize %>% 
  select(-`Flag Codes`,-FREQUENCY)
rice<-rice %>% 
  select(-`Flag Codes`,-FREQUENCY)
soybean<-soybean %>% 
  select(-`Flag Codes`,-FREQUENCY)
full_data<-rbind(wheat,maize,rice,soybean)
iso_none_full<-full_data %>% 
  filter(LOCATION %in% c("BRICS","WLD","OECD")) %>% 
  mutate(LOCATION=ifelse(LOCATION=="WLD","Worldwide",LOCATION))
full_data$LOCATION<-countrycode(full_data$LOCATION,"iso3c","country.name")
iso_yes_full<-full_data %>% 
  drop_na()
full_data_cleaned<-rbind(iso_none_full,iso_yes_full)

distinct_loc <-full_data_cleaned %>% 
  select(LOCATION) %>% 
  distinct(LOCATION)
distinct_sub<-full_data_cleaned %>% 
  select(SUBJECT) %>% 
  distinct(SUBJECT)
distinct_year<-full_data_cleaned %>% 
  select(TIME) %>% 
  distinct(TIME)
df <- world.cities %>%
  filter(capital == 1) %>%
  dplyr::select(LOCATION= country.etc, lat, lng = long) %>%
  left_join(iso_yes_full, by = "LOCATION") %>% 
  drop_na() 
pal_crop<-colorNumeric(palette="Reds",domain=c(min(iso_yes_full$Value):max(iso_yes_full$Value)))
beefnveal<-read_csv("Beef and Veal.csv")
sheep<-read_csv("Sheep.csv")
pork<-read_csv("Pork.csv")
poultry<-read_csv("Poultry.csv")
beefnveal<-beefnveal %>% 
  select(-`Flag Codes`,-FREQUENCY)
sheep<-sheep %>% 
  select(-`Flag Codes`,-FREQUENCY)
pork<-pork %>% 
  select(-`Flag Codes`,-FREQUENCY)
poultry<-poultry %>% 
  select(-`Flag Codes`,-FREQUENCY)
full_data_meat<-rbind(beefnveal,sheep,pork,poultry)
iso_none_meat_full<-full_data_meat %>% 
  filter(LOCATION %in% c("BRICS","WLD","OECD")) %>% 
  mutate(LOCATION=ifelse(LOCATION=="WLD","Worldwide",LOCATION))
full_data_meat$LOCATION<-countrycode(full_data_meat$LOCATION,"iso3c","country.name")
iso_yes_meat_full<-full_data_meat %>% 
  drop_na()
full_data_meat_cleaned<-rbind(iso_none_meat_full,iso_yes_meat_full)
distinct_loc_meat <-full_data_meat_cleaned %>% 
  select(LOCATION) %>% 
  distinct(LOCATION)
distinct_loc_sub<-full_data_meat_cleaned %>% 
  select(SUBJECT) %>% 
  distinct(SUBJECT)
df_1 <- world.cities %>%
  filter(capital == 1) %>%
  dplyr::select(LOCATION= country.etc, lat, lng = long) %>%
  left_join(iso_yes_meat_full, by = "LOCATION") %>% 
  drop_na() 

pal_meat<-colorNumeric(palette="Blues",domain=c(min(iso_yes_meat_full$Value):max(iso_yes_meat_full$Value)))
agriculture<-rbind(full_data_meat_cleaned,full_data_cleaned)
agriculture<-agriculture %>%filter(LOCATION%in%c("Worldwide","OECD","BRICS"))
agriculture_wide<-agriculture %>% 
  select(LOCATION,SUBJECT,TIME,Value) %>% 
  pivot_wider(names_from = SUBJECT,values_from="Value") 
distinct_all<-agriculture %>% select(SUBJECT) %>% distinct(SUBJECT)
distinct_all_location<-agriculture %>% select(LOCATION) %>% distinct(LOCATION)


shinyApp(ui = ui,server = server)