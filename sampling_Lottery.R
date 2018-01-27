#valnilla, for loop


#vanilla, apply
rm(list = ls())
pool <- 1:46
l <- rep(list(pool), 1000)
#with sample funciton
pull <- t(unique(sapply(l, sample, 7, replace = FALSE)))

#function with sapply
rm(list = ls())
TaiwanLottery <- function(n){
        l <- rep(list(1:46), n)
        pull <- t(unique(sapply(l, sample, 7, replace =FALSE)))
        return(pull)
}

#testing the funciton
myLottery <- TaiwanLottery(1000)

#matching
jackpot <- c(05, 27, 29, 36, 40 ,42, 35)
m <- apply(myLottery, 1, match, jackpot)
m
na <- !is.na(m)
use <- apply(na, 2, sum) >= 3
pick <- myLottery[which(use == TRUE), ]

#test
fruit <- c("apple", "banana", "pear", "pineapple")
str_count(fruit, "a")
