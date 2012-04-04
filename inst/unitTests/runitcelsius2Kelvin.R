.setUp <-function () {
}

.tearDown <- function () {}

test.temp10 <- function(){
	# test that at 10°C respiration equals R10
	tempCelsius = c(-10,0,10)
	checkEqualsNumeric( tempCelsius+273.15, celsius2Kelvin(tempCelsius) )
}







