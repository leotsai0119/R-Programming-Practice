rm(list = ls())
#vanilla sampling with for loop
x <- iris$Sepal.Length
s <- list(NULL)
m <- list(NULL)
for(i in 1:50){
      s[[i]] <- sample(x, 30, replace = FALSE)
      m[[i]] <- mean(s[[i]])
      d <- as.data.frame(do.call(rbind, m))
}

#vanilla function with for loop
population <- iris$Sepal.Length
LLN <- function(population, size, times){
        s <- list(NULL)
        m <- list(NULL)
        for(i in 1:times){
                s[[i]] <- sample(population, size, replace = FALSE)
                m[[i]] <- mean(s[[i]])
        }
        d <- as.data.frame(do.call(rbind, m)) #dataframe for ggplot2
        p <- ggplot2::qplot(d$V1, geom = "histogram", bins = 50) #plot
        l <- list("sample" = d, "histogram" = p) #create a list of output objects
        return(l)
}

#test the function
y <- LLN(population, 30, 1000)
d1 <- y$sample
p <- y$histogram

#vanilla sampling with apply
rm(list = ls())
#population <- iris$Sepal.Length
population <- 1:10000
size <- 30
times <- 1000000
m <- matrix(runif(times*size), times, size)
n <- length(population)
p <- ceiling(n*m)
samples <- matrix(population[p], times)