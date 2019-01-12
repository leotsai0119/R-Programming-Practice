rm(list = ls())

#z-distribution
z <- seq(from = 0.00, to = 4.09, by = 0.01)
#pnorm, probabilities of normal distribution
z.df <- round(matrix(pnorm(z, lower.tail = FALSE), ncol = 10, byrow = TRUE), 4)
colnames(z.df) <- sprintf("%.2f", seq(from = 0.00, to = 0.09, by = 0.01)) #sprintf
row.names(z.df) <- sprintf("%.1f", seq(from = 0.0, to = 4.0, by = 0.1)) ; View(z.df)

#student-T distribution
p <- c(.1, .05, .025, .010, .005, .001) #probabilities
df <- c(1:30, 40, 50, 60, 80, 100) #df
#sapply, return a matrix, simplify = "matrix"
t.df <- sapply(p, qt, df, lower.tail = FALSE)
colnames(t.df) <- paste("t", sub("^(-?)0.", "\\1.", sprintf("%.3f", p)))
row.names(t.df) <- df ; View(t.df)

#chi-square distribution
p <- c(0.995, 0.990, 0.975, 0.950,0.900, 0.100, 0.050, 0.025, 0.010, 0.005)
df <- seq(from = 1, to = 60, by = 1)
df[61:66] <- c(70, 80, 90, 100, 110, 120)
chi.df <- round(sapply(p, qchisq, df, lower.tail = FALSE, simplify = "matrix"), 4)
colnames(chi.df) <- paste(sub("^(-?)0.", "\\1.", sprintf("%.3f", p)))
row.names(chi.df) <- df ; View(chi.df)

#fisher distribution
df1 <- c(1:30, seq(40, 120, 10), Inf)
df2 <- df1
f.df.025 <- outer(df1, df2, function(df1, df2) qf(0.025, df1, df2, lower.tail = FALSE))
f.df.05 <- outer(df1, df2, function(df1, df2) qf(0.05, df1, df2, lower.tail = FALSE))
f.df.01 <- outer(df1, df2, function(df1, df2) qf(0.1, df1, df2, lower.tail = FALSE))
colnames(f.df.025) <- df1
row.names(f.df.025) <- df2

#example
y <- 10
sapply(1:10, function(x)(x*y))