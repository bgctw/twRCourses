#include <Rcpp.h>
using namespace Rcpp;

// run after modifications: Rcpp::compileAttributes()


// add a .dot in function name so that its not exported from the package
// [[Rcpp::export(.rcpp_hello_world)]]
List rcpp_hello_world() {
  CharacterVector x = CharacterVector::create("foo", "bar");
  NumericVector y = NumericVector::create( 0.0, 1.0 ) ;
  List z = List::create( x, y ) ;
  return z ;
}


// [[Rcpp::export]]
NumericVector timesTwo(NumericVector x) {
  // Rcpp take care of correct wrapping of simple types
  return x * 2;
}
