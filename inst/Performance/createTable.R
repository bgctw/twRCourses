
createTable1 <- function( 
    ### combine each month with each year and output to a matrix
    parList=list(months=c("Jan","April","Dec"), years=1995:2010)   ##list with names of months and a list of years 
){
    with( parList, {
                res <- character(0)
                for( month in months ){
                    resY <- character(0)
                    for( year in years ){
                        resMY <- paste(month,year)
                        resY <- c(resY, resMY )
                    }
                    res <- cbind( res, resY)
                }
                res
            })
}

createTable1()

