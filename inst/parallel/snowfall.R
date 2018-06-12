#install.packages("snowfall")
#?sfInit
sfInit(parallel=TRUE, cpus=2)

mySubFunction <- function(){ 
  # called from myFancyFunction
}
sfExport("mySubFunction")
?sfLibrary

myFancyFunction <- function(x){ 
  Sys.sleep(0.1)
  mySubFunction()
  1/x 
}
myFancyFunction(1)

myData <- 1:50


t1 <- Sys.time()
result <- lapply(myData, myFancyFunction)
tSpent <- Sys.time() - t1

t1 <- Sys.time()
resultPar <- sfLapply( myData, myFancyFunction)
tSpent2 <- Sys.time() - t1

head(resultPar)


# error handling see parallel1.R