#------ Benchmarking and byte code compiler
#install.packages(c("rbenchmark","compiler","inline","Rcpp"))
library(rbenchmark)
library(Rcpp)

f <- function(n, x = 1) for (i in 1:n) x = 1/(1 + x)

.tmp.f <- function(){
  # no speedup in recent R version?
  library(compiler)
  lf <- cmpfun(f)
  benchmark(f(1e4,1), lf(1e4,1) )[,1:4]		# speedup of 4 to 5
}

.tmp.f <- function(){
  #------- superseded by cppFunction: inline c++ code
  library(inline)
  src <- 'int n = as<int>(ns);
	double x = as<double>(xs);
	for (int i=0; i<n; i++) x=1/(1+x);
	return wrap(x); '
  cppf <- cxxfunction(signature(ns = "integer", xs = "numeric")
                      , body = src, plugin = "Rcpp")	# takes a little time
  cppf(2,1)

  benchmark( f(1e4,1), lf(1e4,1), cppf(1e4,1), cppf2(1e4,1) )[,1:4]	# speedup of about 30

  # may write C code of the function body to a file for fast prototyping
  fx <- cxxfunction(
    signature()
    , paste(readLines( "R/rcpp_hello_world.inline"), collapse = "\n" )
    , plugin = "Rcpp" )
  fx()
}


#-------- inline c++ by cppFunction from Rcpp
cppFunction("
int times3(double x) {
  return x * 3;
}", plugins = c("cpp11"))
times3(3)
# times3(3:4) # not vectorized
# times3("a") # error nicely caught

cppFunction("
double cppf2(int n, double x) {
  for (int i=0; i<n; i++) x=1/(1+x);
	return x;
}", plugins = c("cpp11"))
cppf2(2,1)

benchmark( f(1e4,1),  cppf2(1e4,1) )[,1:4]	# speedup of about 6


#----------- from package

# see src/rcpp_hello_world.cpp
.tmp.testFromOtherWorkspace <- function(){
	# R CMD INSTALL twRCourses
	library(twRCourses)
	pkg <- "twRCourses"
	str(tmp <- showCppHelloWorld())
	str(tmp <- twRCourses:::.rcpp_hello_world())
	timesTwo(c(4.5,6.8)) # vectorized
	#timesTwo("a") # error nicely caught

	#require(Rcpp) by dependencies
	mod <- Module("mod", PACKAGE = pkg)
	mod$simpleNorm(3,4)

}
