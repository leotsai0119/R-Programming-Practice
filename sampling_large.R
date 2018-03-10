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
rm(list = ls())
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
population <- iris$Sepal.Length
#population <- 1:10000
size <- 30
times <- 1000
m <- matrix(runif(times*size), times, size)
n <- length(population)
p <- ceiling(n*m)
samples <- matrix(population[p], times)
#merge into a function
rm(list = ls())
LLN <- function(population, size, times){
        m <- matrix(runif(times*size), times, size) #uniform distribution
        n <- length(population) #calculate numbers of observations
        p <- ceiling(n*m) #not 
        samples <- matrix(population[p], times)
        means <- rowMeans(samples) # calculate means of each observation
        means <- as.data.frame(means) #trans into dataframe for ggplot2
        means$size <- as.factor(size) #factor with 3 levels
        means$times <- as.factor(times) #factor with 3 levls
        return(means)
}

#test
d <- 1:100
d1 <- LLN(d, 10, 1000)
d2 <- LLN(d, 50, 1000)
d3 <- LLN(d, 500, 1000)
d4 <- LLN(d, 10000, 1000)
myData <- rbind.data.frame(d1, d2, d3, d4)
#plotting histograms
p <- ggplot(myData, aes(x = means, fill = size, alpha = .05)) + geom_histogram(binwidth = 5, position = "identity")
p1 <- ggplot(myData, aes(x = means, color = size)) + geom_density()
             