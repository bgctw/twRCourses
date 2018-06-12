\name{respTempLlyodAndTaylor94}
\alias{respTempLlyodAndTaylor94}
\title{respTempLlyodAndTaylor94}
\description{Calculate soil respiration at given Temperature using the Lloyd and Taler model.}
\usage{respTempLlyodAndTaylor94(R10, temp)}
\arguments{
  \item{R10}{numeric vector: respiration rate 10 degrees of Celsius (usually a scalar parameter)}
  \item{temp}{numeric vector: Temperature in Kelvin (see \code{\link{celsius2Kelvin}})}
}
\details{Describes soil respiration at soil core scale. }
\value{numeric vector of soil respiration, same units as R10}
\references{Lloyd, J. & Taylor, J. (1994) On the temperature dependence of soil respiration. Functional ecology, JSTOR, 8, 315-323}
\author{Thomas Wutzler}




\examples{
R10 <- 2		# mumol CO2/m2/s
temp <- seq(5,35,by=1)
resp <- respTempLlyodAndTaylor94(R10,celsius2Kelvin(temp))
plot( resp ~ temp, data=data.frame(temp=temp,resp=resp))
}
