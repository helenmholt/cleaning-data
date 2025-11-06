#class 12
#11/6/2025

#load libraries
library(tidyverse)
library(readxl)
library(summarytools)
library(janitor)

#import data
mangrove <- read_excel("data/messy_mangrove_data.xlsx")

#inspect data
head(mangrove)

view(dfSummary(mangrove))

#make a week column with the number, make long 
print(col(mangrove))

mang_long <- pivot_longer(mangrove, 
                          cols = starts_with("Week"),
                          names_to = "week",
                          names_prefix = "Week ", 
                          values_to = "height"
                          )

#treat all words in height as NA 

#fix different site classifications
clean_mang <- mang_long %>% 
  mutate (Location = case_when(
    str_to_lower(Location) == "site a" ~ "Magens", 
    str_to_lower(Location) == "site b" ~ "Brewers"
  ))

#fix different treatment classifications
unique(clean_mang$Treatment)

clean_mang_treat <- clean_mang %>% 
  mutate (Treatment = case_when(
    Treatment %in% c("control", "Control", "CTRL") ~ "Control", 
    Treatment %in% c("Treatment 1", "T1") ~ "1", 
    Treatment %in% c("Treatment 2", "T2") ~ "2" 
  ))
