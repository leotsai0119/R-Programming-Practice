complete <- function(path, id = 1:length(dir(path))) {
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