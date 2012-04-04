
ds <- data.frame( tr=rep(c("a","b","c"),each=5), repl=rep(1:5,3), val=runif(3*5))

aggRepl <- function(dsRep){
	#recover()
	data.frame( tr=dsRep$tr[1], meanVal=mean(dsRep$val), sdVal=sd(dsRep$valError) )
	#data.frame( tr=dsRep$tr[1], meanVal=mean(dsRep$val), sdVal=sd(dsRep$val) )
}
#dsTr <- subset(ds, tr=="b")
#aggRepl(dsTr)

aggTr <- function(ds){
	resRep <- lapply( levels(ds$tr), function(tri){ aggRepl(subset(ds, tr==tri)) })
	do.call( rbind, resRep )
}
aggTr(ds)

# for same functionality, better use ddply from package plyr 

.tmp.f <- function(){
	#------------ options error
	options(error=recover)
	aggTr(ds)
	source("inst/RCourse/debug1.R")
	
	# stack Trace
	
	# inside browser
	
	#q to quit
	
	options(error=NULL)
	
	#------- setBreakpoint
	# important for debuggin package functions
	#source("inst/RCourse/debug1.R")
	#setBreakpoint("debug1.R#6", tracer=recover )
	
	#--------- trace
	trace(aggRepl, recover )
	aggTr(ds)
	untrace(aggRepl )
	
	#---------- mtrace
	library(debug)
	mtrace(aggRepl)
	aggTr(ds)
	
}

