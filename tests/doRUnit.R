## unit tests will not be done if RUnit is not available
if ( require("RUnit", quietly = TRUE)) {
	#pkg <- "PKG" # <-- Change to package name!
	pkg <- "twRCourses" # <-- ########  Change to package name! ###########################
	pkgPath <- getwd()		# the default for debugging in package workspace
	if ( Sys.getenv("RCMDCHECK") == "FALSE") {
		## Path to unit tests for standalone running under Makefile (not R CMD check)
		## PKG/tests/../inst/unitTests
		pkgPath <- file.path(getwd(),"..")
		instPath <- file.path(pkgPath,"inst")
		path <- file.path(instPath, "unitTests")
	} else {
		## Path to unit tests for R CMD check
		## PKG.Rcheck/tests/../PKG/unitTests
		pkgPath <- system.file(package = pkg)
		instPath <- pkgPath
		path <- file.path(instPath, "unitTests")
	}
	cat("\nSetting up snowfall cluster\n")
	#library(snowfall)
	#sfInit(parallel = TRUE,cpus = 4)
	#source(instPath,"cluster","setupCluster.R")
	#setupClusterHowlandDev(pkgPath)

	cat("\nRunning unit tests\n")
	print(list(pkg = pkg, getwd = getwd(), pathToUnitTests = path))

	library(package = pkg, character.only = TRUE)

	## If desired, load the name space to allow testing of private functions
	## if (is.element(pkg, loadedNamespaces()))
	##     attach(loadNamespace(pkg), name = paste("namespace", pkg, sep = ":"), pos = 3)
	##
	## or simply call PKG:::myPrivateFunction() in tests

	## --- Testing ---

	## Define tests
	testSuite <- defineTestSuite(name = paste(pkg, "unit testing"),
			dirs = path)
	## Run
	tests <- runTestSuite(testSuite)

	## Default report name
	pathReport <- file.path(path, "report")

	## Report to stdout and text files
	cat("------------------- UNIT TEST SUMMARY ---------------------\n\n")
	# printTextProtocol(tests, showDetails = FALSE)
	# printTextProtocol(tests, showDetails = FALSE,
	# 		fileName = paste(pathReport, "Summary.txt", sep = ""))
	# printTextProtocol(tests, showDetails = TRUE,
	# 		fileName = paste(pathReport, ".txt", sep = ""))
	#
	# ## Report to HTML file
	# printHTMLProtocol(tests, fileName = paste(pathReport, ".html", sep = ""))

	## Return stop() to cause R CMD check stop in case of
	##  - failures i.e. FALSE to unit tests or
	##  - errors i.e. R errors
	tmp <- getErrors(tests)
	if ( tmp$nFail > 0 | tmp$nErr > 0) {
		stop(paste("\n\nunit testing failed (#test failures: ", tmp$nFail,
						", #R errors: ",  tmp$nErr, ")\n\n", sep = ""))
	}
} else {
	warning("cannot run unit tests -- package RUnit is not available")
}