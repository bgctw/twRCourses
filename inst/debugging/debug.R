library(nlme)
#load(file="tmp/exampleNmleError.RData")  	#ds1, fm1, ctrl
con <- url("http://www.bgc-jena.mpg.de/~twutz/tmp/exampleNmleError.RData")
load(file=con)  	#ds1, fm1, ctrl
close(con)

ds1 <- subset(ds1, select=c("ColNoM","minT","resp"))
head(ds1)
plot( resp ~ minT, col=rainbow(length(unique(ColNoM)))[ColNoM], ds1)
lines( fitted.values(fm1) ~ minT, ds1 )	# starting values from glns fit

ds2 <- ds1
# ds2 <- unique(ds1)	# does not resolve the error

tmp.fit1 <- nlme(
	resp ~ exp(beta0l) + beta1 * exp(-exp(beta2l)*minT)
	,fixed=list(beta0l+beta1+beta2l~1)	
	,random= beta0l ~ 1 | ColNoM
	, weights =varPower(fixed=0.4, form=~resp)
	, start=list(fixed = coef(fm1))
	#, method='REML'	
	,data=ds2
#,control=ctrl
)
