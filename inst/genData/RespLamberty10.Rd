     \name{RespLamberty10}
     \docType{data}
     \alias{RespLamberty10}
     \title{Soil respiration Database.}
     \description{Example respiration data.}
     \usage{RespLamberty10}
     \format{data.frame with columns \describe{
		\item{Study}{Identifier of the study. }
		\item{resp}{Respiration}
		\item{temp}{Temperature in degree C}
		}
     }
     \source{http://www.nature.com/nature/journal/v464/n7288/extref/nature08930-s2.txt}
     \references{
     	Ben Bond-Lamberty & Allison Thomson, Nature 464, 579-582(25 March 2010), doi:10.1038/nature08930
     }
     \keyword{datasets}
     \examples{
     	data(RespLamberty10)
     	plot( resp~temp, col=Study, data=RespLamberty10)
     }

