# Load required packages
if (!require(caret)) install.packages("caret")
if (!require(dplyr)) install.packages("dplyr")
if (!require(readr)) install.packages("readr")

library(caret)
library(dplyr)
library(readr)

# Load the imputed dataset
gpp <- read.csv("C:/Users/Aimable/Desktop/Renweable Energy/Data/Processed/globalplant_encoded.csv")

# Optional: remove rows where generation_gwh_2019 is NA or zero (if you're predicting this)
gpp <- gpp %>% filter(!is.na(generation_gwh_2019) & generation_gwh_2019 > 0)

# Set seed for reproducibility
set.seed(123)

# Split into training (80%) and testing (20%) using caret
trainIndex <- createDataPartition(gpp$generation_gwh_2019, p = 0.8, list = FALSE)
gpp_train <- gpp[trainIndex, ]
gpp_test  <- gpp[-trainIndex, ]

# Save the datasets
write.csv(gpp_train, "C:/Users/Aimable/Desktop/Renweable Energy/Data/Processed/gpp_train.csv", row.names = FALSE)
write.csv(gpp_test,  "C:/Users/Aimable/Desktop/Renweable Energy/Data/Processed/gpp_test.csv",  row.names = FALSE)

cat("Training and test sets saved in 'Data/Processed' ✅\n")
