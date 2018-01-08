rm(list = ls())
library(readr)
library(data.table)
codebook <- readxl::read_excel("~/R Project/Census 1990/codebook.xlsx")

#from variable "county" to "living"
start <- as.integer(codebook$起[c(1:34, 89:93)])
end <- as.integer(codebook$迄[c(1:34, 89:93)])

#start and end positions
ps <- list(NULL)
pe <- list(NULL)
pp <- list(NULL)
dd <- list(NULL)
path <- "~/R project/Census 1990/Sample 1%/RawData/"

#loo 5 times
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
        #create a list containing all the obs.
        dd[[i]] <- rbindlist(lapply(filepaths, read_fwf, col_positions = pp[[i]]))
        #row binding the elements
        data <- do.call(rbind, dd)
}