importCSV <- function(path, id = 1:length(dir(path))) {
        fileNames <- dir(path)
        filePath <- paste(path, fileNames, sep = "") #paste the file paths
        l <- lapply(filePath, read.csv) #generate a list containing all the files
        do.call(rbind, l) #combine the lists by row
}

#this function returns a data frame which contains full observed cases. ig. withous NAs.
complete <- function(directory, id = 1:332) {
        p <- paste("~/Coursera/R Programming/", directory, "/", sep = "")
        fileNames <- dir(p)[id]
        filePaths <- paste(p, fileNames, sep = "")
        myData <- list(NULL)
        use <- list(NULL)
        ID <- as.character(NULL)
        nobs <- as.numeric(NULL)
        for(i in 1:length(id)) {
                myData[[i]] <- read.csv(filePaths[i])
                c1 <- !is.na(myData[[i]]$sulfate)
                c2 <- !is.na(myData[[i]]$nitrate)
                use[[i]] <- myData[[i]][c1 & c2, ]
                ID[i] <- id[1]
                nobs[i] <- nrow(use[[i]])
        }
        dd <- cbind.data.frame(id, nobs)
        dd
}


corr <- function(directory, threshold = 0) {
        d <- complete(directory)
        clist <- as.numeric(NULL)
        if(d$nobs >= threshold) {
        }
}