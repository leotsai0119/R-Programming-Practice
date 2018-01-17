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
