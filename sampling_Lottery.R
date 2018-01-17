#valnilla, for loop
rm(list = ls())
pool <- 1:46
n <- 10000
l <- list(NULL)
for(i in 1:n) {
        l[[i]] <- sample(pool, 7, replace = FALSE)
}
unique(l)


#vanilla, apply
rm(list = ls())
pool <- 1:46
l <- rep(list(pool), 1000) # create a list full of 1:46
pull <- unique(sapply(l, sample, 7, replace = FALSE)) #unique

#function with sapply
rm(list = ls())

TaiwanLottery <- function(n) {
        l <- rep(list(1:46), n)
        pull <- unique(sapply(l, sample, 7, replace =FALSE))
        return(pull)
}

#testing the funciton
myLottery <- TaiwanLottery(100)

#matching
special <- 35
jackpot <- c(05, 27, 29, 36, 40 ,42, special)
m <- apply(myLottery, 2, match, jackpot)
use <- apply(m, 2, function(x) sum(!is.na(x)))
pick <- myLottery[ , which(use >= 3)]

#pick up sp number
if(length(which((pick == special) == TRUE)) > 0) {
        keep <- which((pick == special) == TRUE, arr.ind = TRUE)[ , 2] # index of columns that have SP
        sp <- pick[ , keep] # with sp number
        nsp <- pick[ , -keep] # withous sp number
        msp <- apply(sp, 2, match, jackpot) #apply match function again
        usp <- apply(mm , 2, function(x) sum(!is.na(x))) 
} else {
        keep <- pick
}


seven <- length(usp[usp == 3])
six <- length(usp[usp == 4])
four <- length(usp[usp == 5])
two <- length(usp[usp == 6])

#na <- !is.na(m)
#use <- apply(na, 2, sum) >= 3
#pick <- myLottery[ , which(use == TRUE)]

#test
fruit <- c("apple", "banana", "pear", "pineapple")
str_count(fruit, "a")
