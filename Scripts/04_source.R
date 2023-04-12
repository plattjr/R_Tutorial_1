library(arrow)
library(tidyverse)
library(data.table)

setwd("C:/Users/plattjr/Downloads/R_Tutorial_1-20230404T172840Z-001/R_Tutorial_1")

source("C:\\Users\\plattjr\\Downloads\\R_Tutorial_1-20230404T172840Z-001\\R_Tutorial_1\\03_function.R")


FMA <- filter_Temp_Health_Data(file_path = "Temp_and_Health.parquet",
                        Sex = "F",
                        Region = "Mountains",
                        Health_Outcome = "Anxiety")
