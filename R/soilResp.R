respTempLlyodAndTaylor94 <- function(
	### Calculate soil respiration at given Temperature using the Lloyd and Taler model.
	R10		##<< numeric vector: respiration rate 10 degrees of Celsius (usually a scalar parameter)
	,temp	##<< numeric vector: Temperature in Kelvin (see \code{\link{celsius2Kelvin}})
){
	##details<< 
	## Describes soil respiration at soil core scale. 
	##references<< 
	##  Lloyd, J. & Taylor, J. (1994) On the temperature dependence of soil respiration. Functional ecology, JSTOR, 8, 315-323
	
	R10*exp( 308.56*(1/56.02 - 1/(temp-227.13)) )
	### numeric vector of soil respiration, same units as R10
}

attr(respTempLlyodAndTaylor94,"ex") <- function(){
	R10 <- 2		# mumol CO2/m2/s
	temp <- seq(5,35,by=1)
	resp <- respTempLlyodAndTaylor94(R10,celsius2Kelvin(temp))
	plot( resp ~ temp, data=data.frame(temp=temp,resp=resp))
}


celsius2Kelvin <- function(
	### Convert temperature from degrees of Celsius to Kelvin.
	temp		##<< numeric vector: the temperature in degress of Celsius.
){
	temp + 273.15
	### numeric vector of length of argument temp: Temperature in Kelvin.
}
