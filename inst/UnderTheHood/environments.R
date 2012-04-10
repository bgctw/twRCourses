

#------- scoping
x <- 5
f <- function() {
	y <- 10
	c(x = x, y = y)
}
f()		# x=5, y=10


a <- 10
f <- function (x) {
	a<-5
	g <- function (y) y + a
	g(x)
}
f(2)		# R: 7 , S: 12


#------- list: modify on copy rule
l <- list()
l$x <- 1:3
f <- function(l) { 
	print(l$x)
	l$x[1] <- 5
	l$x 
}
f(l)  	# 1,2,3   # 5, 2, 3
l$x		# 1, 2, 3


#------- enviornment: reference semantics
e <- new.env(hash = T, parent = emptyenv())
e$x <- 1:3
f <- function(e) { 
	print(e$x)
	e$x[1] <- 5
	e$x 
}
f(e)  	# 1,2,3   # 5, 2, 3
e$x			# 5, 2, 3


#-------- local for avoiding global variables
fibonacci <- local({
		memo <- c(1, 1, rep(NA, 100))
		f <- function(x){
			if(x == 0) return(0)
			if(x < 0) return(NA)
			if(x > length(memo))
				stop("'x' too big for implementation")
			if(!is.na(memo[x])) return(memo[x])
			ans <- f(x-2) + f(x-1)
			memo[x] <<- ans
			ans
		}
	})
sapply( 1:7, fibonacci )


#------- closures
power <- function(exponent) {	function(x) x ^ exponent }

square <- power(2)
square(2) # -> [1] 4
square(4) # -> [1] 16

cube <- power(3)
cube(2) # -> [1] 8
cube(4) # -> [1] 64


#------ Higher order functions
x <- 200:210

is.even <- function(x) x %% 2 == 0
is.odd <- Negate(is.even)
#is.prime <- function(x) gmp::isprime(x) > 1

Filter(is.odd, x)
# [1] 200 202 204 206 208 210


f <- function(x,y){x+y}
x = 1:5 
f(f(f(f(1, 2), 3), 4), 5)
Reduce(f,x)


#------- Exception handling
x <- "A"
res <- try( log(x) ) # throw and error
if( inherits(res,"try-error") )
	res <- NA

in_dir <- function(path, code) {
	cur_dir <- getwd()
	tryCatch({
			setwd(path)
			force(code)
		}, finally = setwd(cur_dir))
}

getwd()
in_dir(R.home(), dir())
getwd()
in_dir(R.home(), stop("Error!"))
getwd()

