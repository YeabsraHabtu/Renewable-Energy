if (!require(corrplot)) install.packages("corrplot")
library(corrplot)


# Set up paths
out_dir <- "C:/Users/Aimable/Desktop/Renweable Energy/Outputs"
dir.create(out_dir, recursive = TRUE, showWarnings = FALSE)

# Define each dataset version
files <- list(
  global_raw    = "C:/Users/Aimable/Desktop/Renweable Energy/Data/Raw/globalpowerplantdatabase.csv",
  global_clean  = "C:/Users/Aimable/Desktop/Renweable Energy/Data/Processed/globalplant_outlier_handled.csv"
)


# Helper to compute correlation matrix for numeric columns
get_corr <- function(path) {
  df <- read.csv(path, stringsAsFactors = FALSE)
  nums <- df[sapply(df, is.numeric)]
  cor(nums, use = "pairwise.complete.obs")
}

# Loop through each, plot and save separately
for (name in names(files)) {
  corr_mat <- get_corr(files[[name]])
  png(file.path(out_dir, paste0("correlation_", name, ".png")),
      width = 800, height = 800)
  corrplot(
    corr_mat,
    method      = "color",
    addCoef.col = "black",
    tl.cex      = 0.8,
    number.cex  = 0.7,
    title       = gsub("_", " ", toupper(name)),
    mar         = c(0,0,2,0)
  )
  dev.off()
}


