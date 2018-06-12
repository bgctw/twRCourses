library(profr)
tmp <- createTable1()
p1 <- profr( {
            for( i in 1:5000){
                #tmp <- createTable1()
                #tmp <- createTable1b()
                #tmp <- createTable1c()
                #tmp <- createTable1d()
                tmp <- createTable1e()
                #tmp <- createTable2()
            }
        } )
plot(p1)

# replacing with
createTable1b <- function( 
        ### combine each month with each year and output a matrix
        parList=list(months=c("Jan","April","Dec"), years=1995:2010)   ##list with names of months and a list of years 
){
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

benchmark( createTable1(), createTable1b(), replications = 1000  )[,1:4]


# replacing c in loop, does not gain speed
createTable1c <- function( 
        ### combine each month with each year and output a matrix
        parList=list(months=c("Jan","April","Dec"), years=1995:2010)   ##list with names of months and a list of years 
){
    res <- character(0)
    for( month in parList$months ){
        resY <- character(0)
        resYi <- lapply( parList$years, function(year){
            resMY <- paste(month,year)
        })
        resY <- do.call( c, resYi )
        res <- cbind( res, resY)
    }
    res
}
createTable1cc <- function( 
        ### combine each month with each year and output a matrix
        parList=list(months=c("Jan","April","Dec"), years=1995:2010)   ##list with names of months and a list of years 
){
    resYi <- lapply(parList$months, function(month){
        resMi <- lapply( parList$years, function(year){
                    resMY <- paste(month,year)
                })
        resY <- do.call( c, resMi )
    })
    res <- do.call( cbind, resYi)
    res
}
createTable1cc()
benchmark( createTable1(), createTable1b(), createTable1c(), createTable1cc(),replications = 1000  )[,1:4]


# converting years to character before
createTable1d <- function( 
        ### combine each month with each year and output a matrix
        parList=list(months=c("Jan","April","Dec"), years=1995:2010)   ##list with names of months and a list of years 
){
    yearsc <- as.character(parList$years)
    res <- character(0)
    for( month in parList$months ){
        resY <- character(0)
        for( year in yearsc ){
            resMY <- paste(month,year)
            resY <- c(resY, resMY )
        }
        res <- cbind( res, resY)
    }
    res
}
benchmark( createTable1(), createTable1b(), createTable1d(), replications = 1000  )[,1:4]

# using outer
createTable1e <- function( 
        ### combine each month with each year and output a matrix
        parList=list(months=c("Jan","April","Dec"), years=1995:2010)   ##list with names of months and a list of years 
){
    t(outer( parList$months, parList$years, paste))
}
createTable1e()
createTable1ee <- function( 
        ### combine each month with each year and output a matrix
        parList=list(months=c("Jan","April","Dec"), years=1995:2010)   ##list with names of months and a list of years 
){
    yearsc <- as.character(parList$years)
    t(outer( parList$months, yearsc, paste))
}
createTable1ee()
benchmark( createTable1(), createTable1b(), createTable1d()
    , createTable1e(), createTable1ee()
    , replications = 1000  )[,1:4]
