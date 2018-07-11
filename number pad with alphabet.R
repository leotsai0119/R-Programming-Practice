#number pad with alphabets
rm(list = ls())
l <- split(letters, rep(2:9, c(3, 3, 3, 3, 3, 4, 3, 4)))
l <- unlist(l, recursive = FALSE)
s <- names(l)

#reverse query
hello <- "helloworld"
sp <- strsplit(hello, split = "", fixed = TRUE)