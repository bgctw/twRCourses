// Generated by using Rcpp::compileAttributes() -> do not edit by hand
// Generator token: 10BE3573-1514-4C36-9D1C-5A225CD40393

#include <Rcpp.h>

using namespace Rcpp;

// rcpp_hello_world
SEXP rcpp_hello_world();
RcppExport SEXP _twRCourses_rcpp_hello_world() {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    rcpp_result_gen = Rcpp::wrap(rcpp_hello_world());
    return rcpp_result_gen;
END_RCPP
}

RcppExport SEXP _rcpp_module_boot_mod();

static const R_CallMethodDef CallEntries[] = {
    {"_twRCourses_rcpp_hello_world", (DL_FUNC) &_twRCourses_rcpp_hello_world, 0},
    {"_rcpp_module_boot_mod", (DL_FUNC) &_rcpp_module_boot_mod, 0},
    {NULL, NULL, 0}
};

RcppExport void R_init_twRCourses(DllInfo *dll) {
    R_registerRoutines(dll, NULL, CallEntries, NULL, NULL);
    R_useDynamicSymbols(dll, FALSE);
}
