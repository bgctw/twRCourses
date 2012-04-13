#------ Benchmarking and byte code compiler
library(rbenchmark)
library(compiler)

f <- function(n, x=1) for (i in 1:n) x=1/(1+x)
lf <- cmpfun(f)
benchmark(f(1e4,1), lf(1e4,1) )		# speedup of 4 to 5

#------- inline c++ code
library(inline)
src <- 'int n = as<int>(ns);
	double x = as<double>(xs);
	for (int i=0; i<n; i++) x=1/(1+x);
	return wrap(x); '
	
cppf <- cxxfunction(signature(ns="integer", xs="numeric")
, body=src, plugin="Rcpp")	# takes a little time

benchmark( f(1e4,1), lf(1e4,1), cppf(1e4,1) )	# speedup of about 30
	