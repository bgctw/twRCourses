f1 <- function(x){
    y <- numeric(length(x)-1)
    for( i in 1:(length(x)-1) )
        y[i] <- x[i] + 2*x[i+1]
    return(y)
}
f2 <- function(x){ x[-length(x)] + 2*x[-1] }
xs <- sample.int(1000)
benchmark( f1(xs), f2(xs) )




