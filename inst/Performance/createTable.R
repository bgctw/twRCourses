# provided a list with names of months and a list of years
# combine each month with each year and output a matrix

createTable1 <- function( parList=list(months, years=1995:2010) ){
	with( parList, {
			res <- character(0)
			for( month in months ){
				resM <- character(0)
				for( year in years ){
					resMY <- paste(month,year)
					resM <- c(resM, resMY )
				}
				res <- cbind( res, resM)
			}
			res
		})
}

createTable2 <- function( parList=list(months, years=1995:2010) ){
	res <- character(0)
	for( month in parList$months ){
		resM <- character(0)
		for( year in parList$years ){
			resMY <- paste(month,year)
			resM <- c(resM, resMY )
		}
		res <- cbind( res, resM)
	}
	res
}