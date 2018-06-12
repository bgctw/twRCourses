#include <Rcpp.h>
using namespace Rcpp;

double norm( double x, double y ) {
	return sqrt( x*x + y*y );
}

//------ exporting a pure C function
RCPP_MODULE(mod) {
	function( "simpleNorm", &norm 
	, List::create( _["x"] = 0.0, _["y"] = 0.0 )
	,"Provides a simple vector norm");
}