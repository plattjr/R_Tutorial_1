library(tidyverse)
library(data.table)
library(arrow)

setwd("C:/Users/plattjr/Downloads/R_Tutorial_1-20230404T172840Z-001/R_Tutorial_1")

# set file paths
csv_path <- "Regions.csv"
parquet_path <- "Regions.parquet"

# read CSV file as arrow table
df <- read_csv(csv_path)

# write arrow table to parquet file
arrow::write_parquet(df, parquet_path)
