if (!require(mice)) install.packages("mice")
if (!require(dplyr)) install.packages("dplyr")
if (!require(readr)) install.packages("readr")
if (!require(caret)) install.packages("caret")

library(mice)
library(dplyr)
library(caret)    # for findCorrelation
library(lattice)  # required by mice
library(ggplot2)  # required by mice

# ---- Global Power Plant Dataset (unchanged) ----
globalpowerplant <- read.csv(
  "C:/Users/Aimable/Desktop/Renweable Energy/Data/Processed/globalpowerplant_cleaned.csv"
)
globalpowerplant[sapply(globalpowerplant, is.character)] <-
  lapply(globalpowerplant[sapply(globalpowerplant, is.character)], as.factor)
globalpowerplant <- globalpowerplant[, colSums(is.na(globalpowerplant)) < nrow(globalpowerplant)]
imputed_gpp <- mice(globalpowerplant, m = 1, method = 'pmm', maxit = 5, seed = 123)
completed_gpp <- complete(imputed_gpp)
write.csv(
  completed_gpp,
  "C:/Users/Aimable/Desktop/Renweable Energy/Data/Processed/globalpowerplant_imputed.csv",
  row.names = FALSE
)