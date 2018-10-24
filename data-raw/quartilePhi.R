library(dplyr)

quartilePhi <- data.frame(
  min = c(0, 0.25, 0.50, 0.75),
  max = c(0.25, 0.50, 0.75, 1.01),
  exp = c(0.876, 0.886, 0.940, 0.874)
)


devtools::use_data(quartilePhi, overwrite = TRUE)
