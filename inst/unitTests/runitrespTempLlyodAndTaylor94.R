.setUp <-function () {
}

.tearDown <- function () {}

test.temp10 <- function(){
	# test that at 10°C respiration equals R10
	R10 <- 2
	checkEqualsNumeric( R10, respTempLlyodAndTaylor94(R10,celsius2Kelvin(10)) )
}







