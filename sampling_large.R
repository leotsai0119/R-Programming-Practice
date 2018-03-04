#vnilla sampling
x <- 1:10000
s1 <- list(NULL)
m1 <- list(NULL)
for(i in 1:50){
      s1[[i]] <-  sample(x, 30, replace = FALSE)
      m1[[i]] <- mean(s1[[i]])
}

lapply(s1, mean)
