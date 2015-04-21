library(parallel)

#?parallel

cl <- makeCluster(2)

mySubFunction <- function(){ 
  # called from myFancyFunction
}
clusterExport(cl, c("mySubFunction"))


myFancyFunction <- function(x){ 
  Sys.sleep(0.1)  # wait for 1/10 of a second
  mySubFunction()
  1/x 
}
myFancyFunction(1)

myData <- 1:50


t1 <- Sys.time()
result <- lapply(myData, myFancyFunction)
(tSpent <- Sys.time() - t1)

t1 <- Sys.time()
resultPar <- parLapply( cl, myData, myFancyFunction)
(tSpent2 <- Sys.time() - t1)

head(resultPar)



#------------- example of tracing error in remote session
throwsError <- function(x){ 
  stop("error in function throwsError.")
}
# function generator dumpOnError in package twMisc
#library(twMisc)
dumpedFun <- dumpOnError(throwsError)  

resultPar <- parLapply(cl, 1:2, dumpedFun)
.tmp.f <- function(){
  options(error=recover)
  load("last.dump.rda")
  debugger()
  # FUN(...)
}

