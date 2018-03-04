rm(list = ls())
#vanilla sampling with for loop
x <- 1:10000
s1 <- list(NULL)
m1 <- list(NULL)
for(i in 1:50){
      s1[[i]] <- sample(x, 30, replace = FALSE)
      m1[[i]] <- mean(s1[[i]])
      d1 <- as.data.frame(do.call(rbind, m1))
}

#vanilla function with for loop
population <- 1:10000
LLN <- function(population, size, times){
        s <- list(NULL)
        m <- list(NULL)
        for(i in 1:times){
                s[[i]] <- sample(population, size, replace = FALSE)
                m[[i]] <- mean(s[[i]])
        }
        d <- as.data.frame(do.call(rbind, m))
        p <- ggplot2::qplot(d$V1, geom = "histogram", bins = 50)
        l <- list("sample" = d, "histogram" = p)
        return(l)
}

#test the function
y <- LLN(population, 30, 1000)
d1 <- y$sample
p <- y$histogram

