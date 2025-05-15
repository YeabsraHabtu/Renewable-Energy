# Set working directory
setwd("C:/Users/Aimable/Desktop/Renweable Energy")

# Load required packages
library(dplyr)
library(readr)

# Load datasets
# Read the data and assign to variables
globalpowerplantdata <- read.csv("C:/Users/Aimable/Desktop/Renweable Energy/Data/Raw/globalpowerplantdatabase.csv")

#To check the parsing issue
problems(globalpowerplantdata)  # For the first dataset

# Clean Power Plant dataset
powerplant_cleaned <- powerplant_df %>%
  select(
    country, capacity_mw, latitude, longitude,
    primary_fuel, commissioning_year,
    generation_gwh_2013:generation_gwh_2019,
    estimated_generation_gwh_2013:estimated_generation_gwh_2017
  )


# Save cleaned datasets
write_csv(powerplant_cleaned, "Data/Processed/globalpowerplant_cleaned.csv")
