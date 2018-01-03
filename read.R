rm(list = ls())
library(readr)
#path <- "~/R Project/Census 1990/Sample 1%/RawData/COUNTY04.txt"
codebook <- readxl::read_excel("~/R Project/Census 1990/codebook.xlsx")

#from variable "county" to "living"
start <- as.integer(codebook$起[c(1:34, 89)])
end <- as.integer(codebook$迄[c(1:34, 89)])

#start and end positions
ps <- list(NULL)
pe <- list(NULL)
pp <- list(NULL)

for(i in 1:5) {
        #generate a list of starts and ends
        ps[[i]] <- c(start[1:9], start[10:34] + 38*(i-1), start[35])
        pe[[i]] <- c(end[1:9], end[10:34] + 38*(i-1), start[35])
        pp[[i]] <- mapply(fwf_positions, ps[[i]], pe[[i]], SIMPLIFY = FALSE, USE.NAMES = FALSE)
        pp[[i]] <- do.call(rbind, pp[[i]])
        pp[[i]]$col_names <- codebook$變項名稱[c(1:34, 89)]
        #read all the files in one directory
        path <- "~/R Project/Census 1990/Sample 1%/RawData/"
        filenames <- dir(path)
        filepath <- paste(path, filenames, sep = "")
}

dd <- lapply("~/R Project/Census 1990/Sample 1%/RawData/COUNTY04.txt")

dd <- read_fwf("~/R Project/Census 1990/Sample 1%/RawData/COUNTY04.txt", col_positions = pp[[4]])
