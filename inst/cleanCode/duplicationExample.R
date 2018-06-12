readInputData <- function(fileName){
    inputData <- read.csv(fileName)
    inputData$site <- strsplit(fileName,"\\.")[[1]][1]
    return(inputData)
}

readMetaDataForFile <- function(fileName){
    site <- strsplit(fileName,"\\.")[[1]][1]
    fileNameMeta <- paste("Meta_",site,".csv", sep="")
    metaData <-  read.csv(fileNameMeta)
}


