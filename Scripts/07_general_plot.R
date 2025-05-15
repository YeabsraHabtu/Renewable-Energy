# Install required packages if not already installed
if (!require(gridExtra)) install.packages("gridExtra", dependencies = TRUE)
if (!require(grid)) install.packages("grid", dependencies = TRUE)
if (!require(ggplot2)) install.packages("ggplot2", dependencies = TRUE)

library(gridExtra)
library(grid)
library(ggplot2)

# Set output directory
output_dir <- "C:/Users/Aimable/Desktop/Renweable Energy/Outputs/"

# Load datasets
df_original <- read.csv("C:/Users/Aimable/Desktop/Renweable Energy/Data/Raw/globalpowerplantdatabase.csv")
df_processed <- read.csv("C:/Users/Aimable/Desktop/Renweable Energy/Data/Processed/globalplant_outlier_handled.csv")

# Extract summaries
summary_original <- summary(df_original$generation_gwh_2019)
summary_processed <- summary(df_processed$generation_gwh_2019)

# Remove "NA's" row if it exists
summary_original <- summary_original[names(summary_original) != "NA's"]
summary_processed <- summary_processed[names(summary_processed) != "NA's"]

# Combine summaries into a data frame
summary_df <- data.frame(
  Statistic = names(summary_original),
  `Before Preprocessing` = as.numeric(summary_original),
  `After Preprocessing` = as.numeric(summary_processed)
)

print(summary_df)

# Save the table as an image
png(filename = paste0(output_dir, "generation_gwh_2019_summary_comparison.png"), width = 900, height = 500)
grid.table(summary_df)
dev.off()
