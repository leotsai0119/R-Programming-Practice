rm(list = ls())

#z-distribution
z <- seq(from = 0.00, to = 4.09, by = 0.01)
#pnorm, probabilities of normal distribution
z.df <- round(matrix(pnorm(z, lower.tail = FALSE), ncol = 10, byrow = TRUE), 4)
colnames(z.df) <- sprintf("%.2f", seq(from = 0.00, to = 0.09, by = 0.01)) #sprintf
row.names(z.df) <- sprintf("%.1f", seq(from = 0.0, to = 4.0, by = 0.1))

#student-T distribution
tquantile <- c(.1, .05, .025, .010, .005, .001) #quantiles
df <- c(1:30, 40, 50, 60, 80, 100) #df
#sapply, return a matrix, simplify = "matrix"
t.df <- sapply(tquantile, qt, df, lower.tail = FALSE, simplify = "matrix")
colnames(t.df) <- paste("t", sub("^(-?)0.", "\\1.", sprintf("%.3f", tquantile)))
row.names(t.df) <- df