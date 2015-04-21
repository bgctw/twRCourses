f1 <- function(x){
  y  <- 1-x
  returnvalue <- f2(y)
  return( returnvalue )
}

f2 <- function(x,flag = "f2"){
  
  returnvalue <- f3(x)
  
  return( returnvalue )
}

f3 <- function(x){
  if(x == 0) stop("Division by 0 not allowed!")
  returnvalue <- 1/x
  return( returnvalue )
}



f1(0)
f1(1)
