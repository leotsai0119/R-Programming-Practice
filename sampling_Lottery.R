#valnilla, for loop
rm(list = ls())
pool <- 1:46
n <- 10000
l <- list(NULL)
for(i in 1:n) {
        l[[i]] <- sample(pool, 7, replace = FALSE)
}
unique(l)

#vanilla, list with sapply
rm(list = ls())
pool <- 1:46
l <- rep(list(pool), 1000) # create a list full of 1:46
pull <- unique(sapply(l, sample, 7, replace = FALSE)) #unique

#matrix_
rm(list = ls())
n <- 100
m <- matrix(1:49, ncol = n, nrow = 49)
pull <- unique(apply(m, 2, sample, 7, replace = FALSE))

#function with sapply
rm(list = ls())

TaiwanLottery <- function(n) {
        l <- rep(list(1:46), n)
        pull <- unique(sapply(l, sample, 7, replace =FALSE))
        return(pull)
}

#function with matrix and apply
rm(list = ls())

TaiwanLottery <- function(n) {
        m <- matrix(1:49, ncol = n, nrow = 49)
        pull <- unique(apply(m, 2, sample, 7, replace = FALSE))
        return(pull)
}

#testing the funciton
myLottery <- TaiwanLottery(10000)

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
        usp <- apply(msp , 2, function(x) sum(!is.na(x)))
        mnsp <- apply(nsp, 2, match, jackpot) # apply match function
        unsp <- apply(mnsp, 2, function(x) sum(is.na(x)))
} else {
        keep <- pick
}

eight <- length(unsp[unsp == 3])
seven <- length(usp[usp == 3])
six <- length(usp[usp == 4])
five <- length(unsp[unsp == 4])
four <- length(usp[usp == 5])
three <- length(unsp[unsp == 5])
two <- length(usp[usp == 6])
one <- length(unsp[unsp == 6])

#merge into a single function
TaiwanLottery <- function(n, numbers, special) {
        m <- matrix(1:49, ncol = n, nrow = 49)
        myLottery <- unique(apply(m, 2, sample, 7, replace = FALSE))
        jackpot <- c(numbers, special)
        m <- apply(myLottery, 2, match, jackpot)
        use <- apply(m, 2, function(x) sum(!is.na(x)))
        pick <- myLottery[ , which(use >= 3)]
}