rm(list = ls())
library(readr)
#library(magrittr)
library(data.table)
#path <- "~/R Project/Census 1990/Sample 1%/RawData/COUNTY04.txt"
codebook <- readxl::read_excel("~/R project/codebook.xlsx")

#from variable "county" to "living"
start <- as.integer(codebook$起[c(1:34, 89:93)])
end <- as.integer(codebook$迄[c(1:34, 89:93)])

#start and end positions
ps <- list(NULL)
pe <- list(NULL)
pp <- list(NULL)
dd <- list(NULL)
#data <- list(NULL)

path <- "~/R project/RawData/"

for(i in 1:5) {
        #generate a list of starts and ends
        ps[[i]] <- c(start[1:9], start[10:34] + 38*(i-1), start[35:39])
        pe[[i]] <- c(end[1:9], end[10:34] + 38*(i-1), start[35:39])
        pp[[i]] <- mapply(fwf_positions, ps[[i]], pe[[i]], SIMPLIFY = FALSE, USE.NAMES = FALSE)
        pp[[i]] <- do.call(rbind, pp[[i]])
        pp[[i]]$col_names <- codebook$變項名稱[c(1:34, 89:93)]
        
        #read all the files in one directory
        filenames <- dir(path)
        filepaths <- paste(path, filenames, sep = "")
        #lapply(filepaths, read_fwf, col_positions = pp[[1]]) %>% do.call(rbind)
        dd[[i]] <- lapply(filepaths, read_fwf, col_positions = pp[[i]])
        data <- do.call(rbindlist, dd[[i]][[i]])
}

dd <- read_fwf("~/R Project/Census 1990/Sample 1%/RawData/COUNTY04.txt", col_positions = pp[[4]])
