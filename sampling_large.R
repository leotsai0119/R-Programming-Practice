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
                s[[i]] <- sample(population, size, replace = TRUE)
                m[[i]] <- mean(s[[i]])
        }
        d <- as.data.frame(do.call(rbind, m)) #dataframe for ggplot2
        p <- ggplot2::qplot(d$V1, geom = "histogram", bins = 50) #plot
        l <- list("sample" = d, "histogram" = p) #create a list of output objects
        return(d)
}

#test the function
d <- 1:100
d1 <- LLN(d, 5, 10000)
d2 <- LLN(d, 50, 10000)
d3 <- LLN(d, 500, 10000)
d4 <- LLN(d, 5000, 10000)
myData <- rbind.data.frame(d1, d2, d3, d4)
#plotting histograms and density curves
p1 <- ggplot(myData, aes(x = V1, fill = size, alpha = .05)) + geom_histogram(binwidth = .5, position = "identity") + facet_grid(~size) + theme_classic()
p2 <- ggplot(myData, aes(x = V1, color = size)) + geom_density() + theme_classic()

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
d1 <- LLN(d, 5, 100)
d2 <- LLN(d, 50, 100)
d3 <- LLN(d, 500, 100)
d4 <- LLN(d, 5000, 100)

myData <- rbind.data.frame(d1, d2, d3, d4)
m <- aggregate.data.frame(myData$means, list(myData$times), mean)
#plotting histograms and density curves

p1 <- ggplot(myData, aes(x = means, fill = times, alpha = .05)) + geom_histogram(binwidth = .1, position = "identity") + facet_grid(. ~ times) + theme_classic()
p2 <- ggplot(myData, aes(x = means, color = times)) + geom_density() + theme_classic()

p_mu <- ggplot(iris) + aes(x = iris$Sepal.Length, alpha = .05) + geom_histogram(binwidth = .1) + theme_classic()
             
p1 <- ggplot(myData, aes(x = means, fill = times, alpha = .03)) + geom_histogram(binwidth = .5, position = "identity") + theme_classic()
pm <- geom_vline(aes(xintercept = mean(d)), color = "blue", linetype = "dashed")
pmm <- geom_vline(aes(xintercept = m$x), color = "black", linetype = "dashed")
p <- p1 + pm + pmm
p2 <- ggplot(myData, aes(x = means, color = size)) + geom_density() + theme_classic()