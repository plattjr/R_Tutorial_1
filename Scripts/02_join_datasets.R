library(arrow)
library(data.table)


open_dataset("Temperature_Data.parquet") %>%
  select(-TMAX, -TMIN)


open_dataset("Health_Data.parquet") %>%
  select(admitdt, zip5, sex, Mental_Health, Anxiety) %>%
  group_by(admitdt, zip5) %>%
  summarise(Mental_Health = sum(Mental_Health),
            Anxiety = sum(Anxiety)) %>%
  rename(Date = admitdt,
         Zip = zip5)

#=========================================#
# Regions
#=========================================#

Regions <- fread("Regions.csv")

Mountains <- Regions %>%
  filter(Region == "Mountains") %>%
  select(ZCTA)

Piedmont <- Regions %>%
  filter(Region == "Piedmont") %>%
  select(ZCTA)

Coast <- Regions %>%
  filter(Region == "Coast") %>%
  select(ZCTA)


#=========================================#
# Joining Temp and Health Data
#=========================================#

Temp_and_Health <- left_join(open_dataset("Temperature_Data.parquet") %>%
                               select(-TMAX, -TMIN),
                             open_dataset("Health_Data.parquet") %>%
                               select(admitdt, zip5, sex, Mental_Health, Anxiety) %>%
                               group_by(admitdt, zip5, sex) %>%
                               summarise(Mental_Health = sum(Mental_Health),
                                         Anxiety = sum(Anxiety)) %>%
                               rename(Date = admitdt,
                                      Zip = zip5),
                             by = c("Date", "Zip")) %>%
                    collect() %>%
                    filter(Date >= "2018-01-01") %>%
                    mutate(region = ifelse(Zip %in% Mountains$ZCTA, "Mountains",
                                    ifelse(Zip %in% Piedmont$ZCTA, "Piedmont",
                                    ifelse(Zip %in% Coast$ZCTA, "Coast", ""))))

# Check Data #
summary(Temp_and_Health)

#=========================================#
# Write to Parquet
#=========================================#

write_parquet(Temp_and_Health, "Temp_and_Health.parquet")



