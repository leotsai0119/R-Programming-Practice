rm(list = ls())

#z-distribution
z <- seq(from = 0.00, to = 4.09, by = 0.01)
z.df <- round(matrix(pnorm(z, lower.tail = FALSE), ncol = 10, byrow = TRUE), 4)
colnames(z.df) <- sprintf("%.2f", seq(from = 0.00, to = 0.09, by = 0.01))
row.names(z.df) <- sprintf("%.1f", seq(from = 0.0, to = 4.0, by = 0.1))

                          