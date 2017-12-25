importCSV <- function(path, id = 1:length(dir(path))) {
        fileNames <- dir(path)
        filePath <- paste(path, fileNames, sep = "") #paste the file paths
        l <- lapply(filePath, read.csv) #generate a list containing all the files
        do.call(rbind, l) #combine the lists by row
}