library(arrow)
library(tidyverse)
library(data.table)

filter_Temp_Health_Data <- function(file_path, Sex, Region, Health_Outcome){


Males_Mountain_Anxiety <- open_dataset(file_path) %>%
  filter(sex == Sex,
         region == Region) %>%
  rename(Outcome = Health_Outcome) %>%
  select(Outcome, Zip, Date, TAVG, RH) %>%
  collect()
}



