library(parallel)
#?parallel     # see also vignette
cl <- makeCluster( 2L )     # detectCores()
#setDefaultCluster(NULL)


myFancyFunction <- function(x){ 
    Sys.sleep(0.1)  # wait for 1/10 of a second
    1/x 
}

myData <- 1:50

t1 <- Sys.time()
result <- lapply(myData, myFancyFunction)
(tSpent <- Sys.time() - t1)     # 5 seconds

t1 <- Sys.time()
resultPar <- parLapply( cl, myData, myFancyFunction)
(tSpent2 <- Sys.time() - t1)    # 2.5 seconds    

stopCluster(cl)

#resultPar <- parLapplySave( cl, myData, myFancyFunction)


#------------------- Need of exporting objects
mySubFunction <- function(){}

myMasterFunction <- function(x){ 
  Sys.sleep(0.1)  # wait for 1/10 of a second
  mySubFunction()
  1/x 
}

# produces error: "mySubFunction" not found
parLapply(cl, 1:2, myMasterFunction )   

# Need to explicitely transfer mySubFunction.
# The envir argument is necessary if exporting from a function
# instead of the global environment. 
clusterExport(cl, c("mySubFunction"), envir=environment())
parLapply(cl, 1:2, myMasterFunction )   



#------------- example of tracing error in remote session
throwsError <- function(x){ 
  stop("error in function throwsError.")
}
#resultPar <- parLapply(cl, 1:2, throwsError)

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

