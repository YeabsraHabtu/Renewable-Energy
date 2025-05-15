# ─── Step 1: Load libraries ────────────────────────────────────────────────
if (!require(data.table)) install.packages("data.table")
if (!require(readr)) install.packages("readr")

library(data.table)
library(readr)

# ─── Step 2: Read in your imputed dataset ─────────────────────────────────
gpp <- fread("C:/Users/Aimable/Desktop/Renweable Energy/Data/Processed/globalpowerplant_imputed.csv")

# ─── Step 3: Identify numeric columns ─────────────────────────────────────
numeric_cols <- names(gpp)[sapply(gpp, is.numeric)]

# ─── Step 4: Detect outliers using IQR and summarize ──────────────────────
outlier_stats <- lapply(numeric_cols, function(col) {
  x <- gpp[[col]]
  q1 <- quantile(x, 0.25, na.rm = TRUE)
  q3 <- quantile(x, 0.75, na.rm = TRUE)
  iqr <- q3 - q1
  lower <- q1 - 1.5 * iqr
  upper <- q3 + 1.5 * iqr
  n_out <- sum(x < lower | x > upper, na.rm = TRUE)
  prop <- round(n_out / length(x), 4)
  list(variable = col, n_outliers = n_out, prop = prop, lower = lower, upper = upper)
})

outlier_df <- rbindlist(outlier_stats)
print(outlier_df)

# ─── Step 5: Manually Winsorize outliers at IQR boundaries ────────────────
for (col in numeric_cols) {
  bounds <- outlier_df[variable == col]
  lower <- bounds$lower
  upper <- bounds$upper
  gpp[[col]] <- pmin(pmax(gpp[[col]], lower), upper)
}


# ─── Step 6: Save cleaned data ────────────────────────────────────────────


# Correct commissioning_year decimals
gpp_clean$commissioning_year <- round(gpp_clean$commissioning_year)

# Save cleaned data
write_csv(
  gpp_clean,
  "C:/Users/Aimable/Desktop/Renweable Energy/Data/Processed/globalplant_outlier_handled.csv"
)

cat("Outlier detection and Winsorizing complete.\nFile saved.\n")
