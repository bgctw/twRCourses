months <- month.abb[ sample.int(12,2000,replace=TRUE) ]
pL <- list(months=months, years=1995:2000)
n <- 20
(st1 <- system.time( replicate(n,creteTable1(pL)) )["elapsed"])

library(profr)
p1 <- profr( replicate(n,creteTable1()), 0.02 )
plot(p1)

Rprof()
#for( i in 1:n ) mySort(m)
for( i in 1:n ) creteTable1()
#for( i in 1:n ) mySort3(m)
Rprof(NULL)
(t1 <- subset(summaryRprof()$by.self, select=c("total.time","self.time")))


# getting rid of with (eval)
creteTable2 <- function( parList ){
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
(st2 <- system.time( replicate(n, creteTable2(pL) ))["elapsed"])
Rprof()
#for( i in 1:n ) mySort(m)
for( i in 1:n ) creteTable2(pL)
#for( i in 1:n ) mySort3(m)
Rprof(NULL)
(t2 <- subset(summaryRprof()$by.self, select=c("total.time","self.time")))


creteTable2b <- function( parList ){
	yearsC <- as.character(parList$years)
	res <- character(0)
	for( month in parList$months ){
		resM <- character(0)
		for( year in yearsC ){
			resMY <- paste(month,year)
			resM <- c(resM, resMY )
		}
		res <- cbind( res, resM)
	}
	res
}
(st2b <- system.time( replicate(n, creteTable2b(pL) ))["elapsed"])
Rprof()
#for( i in 1:n ) mySort(m)
for( i in 1:n ) creteTable2b(pL)
#for( i in 1:n ) mySort3(m)
Rprof(NULL)
(t2b <- subset(summaryRprof()$by.self, select=c("total.time","self.time")))

creteTable2c <- function( parList=list(months, years=1995:2000) ){
	yearsC <- as.character(parList$years)
	res <- character(0)
	for( month in parList$months ){
		resM <- paste(month, yearsC)
		res <- cbind( res, resM)
	}
	res
}
(st2c <- system.time( replicate(n, creteTable2c(pL) ))["elapsed"])
Rprof()
#for( i in 1:n ) mySort(m)
for( i in 1:n ) creteTable2c(pL)
#for( i in 1:n ) mySort3(m)
Rprof(NULL)
(t2c <- subset(summaryRprof()$by.self, select=c("total.time","self.time")))

creteTable2d <- function( parList ){
	yearsC <- as.character(parList$years)
	res <- matrix( NA_character_, nrow=length(parList$years), ncol=length(parList$months) )
	months <- parList$months
	for( iMonth in 1:length(months) ){
		res[,iMonth] <- paste(months[iMonth], yearsC)
	}
	res
}
(st2d <- system.time( replicate(n, creteTable2d(pL) ))["elapsed"])
Rprof()
#for( i in 1:n ) mySort(m)
for( i in 1:n ) creteTable2d(pL)
#for( i in 1:n ) mySort3(m)
Rprof(NULL)
(t2d <- subset(summaryRprof()$by.self, select=c("total.time","self.time")))


creteTable10 <- function( parList ){
	with( parList, {
		outer( months, years, paste)
	})
}
(t210 <- system.time( replicate(n, creteTable3(pL) ))["elapsed"])

creteTable11 <- function( parList ){
	outer( parList$months, parList$years, paste)
}
(t211 <- system.time( replicate(n, creteTable11(pL) ))["elapsed"])


creteTable11b <- function( parList ){
	outer( parList$months, as.character(parList$years), paste)
}
(st11b <- system.time( replicate(n, creteTable11b(pL) ))["elapsed"])
