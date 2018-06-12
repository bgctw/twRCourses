showCppHelloWorld <- function(
  ### call internal function \code{.rcpp_hello_world}
  ...  ##<< further arguments to \code{.rcpp_hello_world}
){
  ##details<< This function demonstrates renaming of cpp funcitons.
  ## Due to starting with the dot, it will not be available from outside
  ## the package.
  ##
  ## This is alwo a way to use inlinedocs to document the funciton instead
  ## of modifying the .Rd created by Rcpp::compileAttributes().
  #
  ##value<< result of \code{.rcpp_hello_world}
  .rcpp_hello_world(...)
}
