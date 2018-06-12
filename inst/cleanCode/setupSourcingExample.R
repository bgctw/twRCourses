setwd("inst/cleanCode")


fancyData <- data.frame(
        treatment <- "control"
        ,respiration <- rnorm(10)
        )
        

write.csv(fancyData, "fancyData.csv")