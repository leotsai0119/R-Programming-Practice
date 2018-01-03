pollutantmean <- function(directory, pollutant, id = 1:332) {
        p <- paste("~/Coursera/R Programming/", directory, "/", sep = "")
        fileNames <- dir(p)[id]
        filePaths <- paste(p, fileNames, sep = "")
        myData <- list(NULL)
        for (i in 1:length(id)) {
                myData[[i]] <- read.csv(filePaths[i])
        }
        d <- do.call("rbind", myData)
        NAs <- is.na(d[pollutant])
        use <- d[!NAs, ]
        pMean <- sum(use[pollutant]) / nrow(use)
        pMean
}