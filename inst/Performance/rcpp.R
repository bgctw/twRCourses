#------ Benchmarking and byte code compiler
library(rbenchmark)
library(compiler)

f <- function(n, x=1) for (i in 1:n) x=1/(1+x)
lf <- cmpfun(f)
benchmark(f(1e4,1), lf(1e4,1) )		# speedup of 4 to 5


#------- vectorizing example 
x <- sample.int(10)
y <- numeric(length(x)-1)
for( i in 1:(length(x)-1) )
	y[i] <- x[i] + 2*x[i+1] 
y2 <- x[-length(x)] + 2*x[-1]

#------- inline c++ code
library(inline)
src <- 'int n = as<int>(ns);
	double x = as<double>(xs);
	for (int i=0; i<n; i++) x=1/(1+x);
	return wrap(x); '
	
cppf <- cxxfunction(signature(ns="integer", xs="numeric")
, body=src, plugin="Rcpp")	# takes a little time

benchmark( f(1e4,1), lf(1e4,1), cppf(1e4,1) )	# speedup of about 30
	
# may write C code of the function body to a file for fast prototyping
fx <- cxxfunction( signature(),paste(readLines( "src/rcpp_hello_world.inline"), collapse = "\n" ), plugin = "Rcpp" )
fx()

.tmp.doesNotWorkBecauseOfIncludesAndFunctionDef <- function(){
	inDir <- function(path, code) {
		cur_dir <- getwd()
		tryCatch({
				setwd(path)
				force(code)
			}, finally = setwd(cur_dir))
	}
	fx <- inDir("src",{ 
				tmp <- readLines( "rcpp_hello_world.cpp")
				cxxfunction( signature(),paste( tmp[ !(1:length(tmp) %in% grep("#include",tmp)) ], collapse = "\n" ),
				plugin = "Rcpp" )}
	)
}

#-------- RCpp package
#Rcpp.package.skeleton("cppTemplatePackage", module=TRUE)
pkg <- "twRCourses"
# package needs to link to the Rcpp library (dll or so)
# In file src/Makevars:	PKG_LIBS = `$(R_HOME)/bin/Rscript -e "Rcpp:::LdFlags()"`
# In file src/Makevars.win:  PKG_LIBS = $(shell "${R_HOME}/bin${R_ARCH_BIN}/Rscript.exe" -e "Rcpp:::LdFlags()")
# In file Namespace:  useDynLib(mypackage)


.tmp.compile <- function(){
	dynFilenameLocal <- file.path("src",paste(pkg, .Platform$dynlib.ext, sep = ""))
	dyn.unload(dynFilenameLocal)
	fnames <- paste(Sys.glob("src/*.cpp"), collapse=" ")
	system(tmp <- paste("R CMD SHLIB -o ",dynFilenameLocal," ",fnames,sep=""))
	#unlink(file.path("src","*.o"))
	dyn.load(dynFilenameLocal)
}
(tmp <- .Call( "rcpp_hello_world", PACKAGE = pkg ))

mod <- Module("mod", PACKAGE = pkg)
mod$norm(3,4)



.tmp.testFromOtherWorkspace <- function(){
	# R CMD INSTALL twRCourses
	library(twRCourses)
	pkg <- "twRCourses"
	(tmp <- .Call( "rcpp_hello_world", PACKAGE = pkg ))
	simpleNorm(3,4)
	
	#require(Rcpp) by dependencies
	mod <- Module("mod", PACKAGE = pkg)
	mod$simpleNorm(3,4)
	
}
