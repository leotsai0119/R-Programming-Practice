library(tidyverse)
# vanilla
# step by step
ID <- "Q123395006"

# check the length
if(length(ID) != 10){
        print("invalid ID length")
}

verify_ID <- function(idstr){
        # convert all to utf-8 points
        x <- strsplit(idstr, split = "") %>% .[[1]]
        x <- lapply(x, utf8ToInt) %>% unlist()
        # check the length
        if(length(x) != 10){
                print("incorrect ID length")
                }
        # check the first character
        if(x[1] < 65 || x[1] > 90){
                print("the first character is invalid")
                }
        # check remaining characters
        if(!(x[2] %in% c(49, 50))){
                print("incorrect sex")
                }
}
