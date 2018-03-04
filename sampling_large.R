#vanilla sampling with for loop
x <- 1:10000
s1 <- list(NULL)
m1 <- list(NULL)
for(i in 1:50){
      s1[[i]] <-sample(x, 30, replace = FALSE)
      m1[[i]] <- mean(s1[[i]])
      d1 <- as.data.frame(do.call(rbind, m1))
}

#vanilla function with for loop