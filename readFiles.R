importCSV <- function(path, id = 1:length(dir(path))) {
        fileNames <- dir(path)
        filePath <- paste(path, fileNames, sep = "") #paste the file paths
        l <- lapply(filePath, read.csv) #generate a list containing all the files
        do.call(rbind, l) #combine the lists by row
}

#testing the function line by line
path <- "~/Coursera/R Programming/week2/specdata/"
fileNames <- dir(path)
filePath <- paste(path, fileNames, sep = "")
myData <- lapply(filePath, read.csv)

#testing the function importCSV
myData <- importCSV("~/Coursera/R Programming/week2/specdata/")
