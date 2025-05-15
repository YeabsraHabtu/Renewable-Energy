# ─── Step 1: Load Required Libraries ─────────────────────────────────────────
if (!require(dplyr)) install.packages("dplyr")
if (!require(readr)) install.packages("readr")

library(dplyr)
library(readr)

# ─── Step 2: Load the CSV File ──────────────────────────────────────────────
file_path <- "C:/Users/Aimable/Desktop/Renweable Energy/Data/Processed/globalplant_outlier_handled.csv"
gpp <- read_csv(file_path)

# ─── Step 3: Encode 'primary_fuel' (One-Hot) ─────────────────────────────────
# Convert to factors if not already
gpp$primary_fuel <- as.factor(gpp$primary_fuel)

# One-hot encode
primary_fuel_dummies <- as.data.frame(model.matrix(~ primary_fuel - 1, data = gpp))

# ─── Step 4: Encode 'country' (Label Encoding) ───────────────────────────────
gpp$country <- as.integer(factor(gpp$country))

# ─── Step 5: Combine Everything ──────────────────────────────────────────────
# Drop original 'primary_fuel' and bind dummy variables
gpp_encoded <- gpp %>%
  select(-primary_fuel) %>%
  bind_cols(primary_fuel_dummies)

# ─── Step 6: Save the Final Encoded Dataset ─────────────────────────────────
output_path <- "C:/Users/Aimable/Desktop/Renweable Energy/Data/Processed/globalplant_encoded.csv"
write_csv(gpp_encoded, output_path)

cat("✅ Encoding complete. Encoded file saved as globalplant_encoded.csv\n")
