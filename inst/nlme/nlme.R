library(twNlme)

data(Wutzler08BeechStem)
head(Wutzler08BeechStem)
ds <- Wutzler08BeechStem[order(Wutzler08BeechStem$dbh),]
plot( stem~dbh, col=author, data=ds, xlab="dbh [cm]", ylab="")
mtext( "stem biomass [kg]", 2, 2.5, las=0)
legend( "topleft", inset=c(0.01,0.01), levels(ds$author), col=1:13, pch=1 )
#ds <- Wutzler08BeechStem[ Wutzler08BeechStem$dbh > 16, ]
#plot( log(stem)~log(dbh), col=author, data=ds)

#------------------  fit without grouping
# infer starting values
lm1 <- lm( log(stem)~log(dbh), data=ds )
.start <- structure( c( exp(coef(lm1)[1]), coef(lm1)[2] ), names=c("b0","b1")) 
#y <- with( ds, .start["b0"] * dbh^.start["b1"]) 
#plot( stem~dbh, col=author, data=ds)
#lines( y ~ dbh, data=ds )

gm1 <- gnls( stem ~ b0 * dbh^b1 
    , data=ds 
    , params=c(b0+b1~1)
    , start=.start   
    , weights=varPower(form = ~fitted(.))
)

#plot( stem~dbh, col=author, data=ds, xlab="dbh [cm]", ylab="")
plot( stem~dbh, data=ds, xlab="dbh [cm]", ylab="")
mtext( "stem biomass [kg]", 2, 2.5, las=0)
lines( fitted(gm1) ~ dbh, data=ds, col="black", lwd=2 )

sdEps <- sqrt( varResidPower(gm1, pred=fitted(gm1)) )
gm1a <- attachVarPrep(gm1, fVarResidual=varResidPower)
sd <- varPredictNlmeGnls(gm1a, newdata=ds)[,"sdInd"] 
lines( fitted(gm1)+sd ~ dbh, data=ds, col="grey" )
lines( fitted(gm1)-sd ~ dbh, data=ds, col="grey" )

#------------ uncertainty of biomass-sum over n trees?
n <- 1000      # sum over n trees
set.seed(0815)
dsNew <- data.frame(dbh=rnorm(n, mean=30, sd=2), author=ds$author[1])   # although there is no new author
yNew <- predict(gm1a, newdata=dsNew )
varNew <- varPredictNlmeGnls(gm1a, newdata=dsNew)
head(varNew)        # fixed effects have only a minor proportion
sdNew <- varNew[,"sdInd"]
mean( sdNew/yNew )       # on average each tree biomass with 33% uncertainty
yAgg <- sum(yNew)
sdYAgg <- sqrt( sum(varNew) )       # completely independent
(cvYAgg <- sdYAgg/yAgg )      # only 1% uncertainty ? 

# assuming independent trees: add standard deviation
sdYAgg <- sum( sqrt(varNew) )
(cvYAgg <- sdYAgg/yAgg )      # 33% uncertainty - did not decrease with n at all?

#
varSumComp <- varSumPredictNlmeGnls(gm1a, newdata=dsNew, retComponents = TRUE)
varSumComp      # big effect of uncertainty in coefficients
(cvYAgg <- varSumComp["sdPred"]/yAgg )      # 3.1%


#----------------- account for grouping
mm1 <- nlme( stem ~ b0 * dbh^b1 
        , data=ds 
        , fixed=c(b0+b1~1)
        , random=list(author=c(b0 ~1))
        #, random=list(author=c(b1 ~1))
        #, random=list(author=c(b0+b1 ~1))
        , start=.start   
        , weights=varPower(form = ~fitted(.)|author)
)
mm1

plot( stem~dbh, col=author, data=ds, xlab="dbh [cm]", ylab="")
mtext( "stem biomass [kg]", 2, 2.5, las=0)
yds <- predict(mm1, level=0) 
lines( yds ~ dbh, data=ds, col="black", lwd=2)

#authors <- levels(ds$author)
authors <- c("Heinsdorf","Cienciala","Duvigneaud2")
for( authorI in authors){
    dsNa <- ds; dsNa$author[] <- authorI
    try(lines( predict(mm1, level=1, newdata=dsNa) ~ dbh, data=dsNa, col=which(authorI == levels(ds$author)) ))
}
legend( "topleft", inset=c(0.01,0.01), legend=c(sort(authors),"Population"), col=c(which(levels(ds$author) %in% authors),"black"), lty=1, lwd=c(rep(1,length(authors)),2) )

#sd <- sqrt( varResidPower(gm1, pred=predict(mm1, level=0)) )
mm1a <- attachVarPrep( mm1, fVarResidual=varResidPower)     # calculate symbolic derivatives used in variance prediction
sd <-varPredictNlmeGnls(mm1a, newdata=ds)[,"sdInd"]     # variance components
lines( yds+sd ~ dbh, data=ds, col="grey" )
lines( yds-sd ~ dbh, data=ds, col="grey" )


# additional unertainty of random effects
yNew <- predict(mm1, newdata=dsNew, level=0 )
(varPredictNlmeGnls(mm1a, newdata=dsNew[1:10,,drop=FALSE]))     # variance components
# variance of the sum over trees
(varSumCompM <- varSumPredictNlmeGnls(mm1a, newdata=dsNew, retComponents = TRUE))
#        pred       sdPred       varFix       varRan     varResid 
# 4.650287e+05 5.487312e+04 3.599002e+08 2.651159e+09 4.031291e+01 
#  variance due to random effects 2 order of magnitudes bigger than residual variance
yAgg <- sum(yNew)
(cvAggEps <- sqrt(varSumCompM["varResid"]) / yAgg )     # 0.7% uncertainty
(cvAggFix <- sqrt(varSumCompM["varFix"]) / yAgg )     
(cvAggRand <- sqrt(varSumCompM["varRan"]) / yAgg )     
(cvAgg <- varSumCompM["sdPred"] / yAgg )     # 26% uncertainty
(cvAggPop <- sqrt( sum(varSumCompM[c("varFix","varRan")])) / yAgg )     # still 26% uncertainty


#-------------------- bootstrap uncertainty
require(mnormt)     # multivariate normal
nBoot <- 400

beta <- rmnorm(nBoot, fixef(mm1), varFixef(mm1) )       # random realizations of fixed effects
b0 <- rnorm(nBoot, 0 , sqrt(varRanef(mm1)) )            # random realizations of b0
sigma0 <- mm1$sigma 
delta <- mean( coef(mm1$modelStruct$varStruct,uncons = FALSE, allCoef = TRUE), nBoot, replace=TRUE)
#i <- 1
res <- sapply( 1:nBoot, function(i){
            yNewP <- (beta[i,"b0"]+b0[i]) * dsNew$dbh^(beta[i,"b1"])
            sigma <- sigma0 * yNewP^delta
            eps <- rnorm( nrow(dsNew), 0, sigma)                      # random realizations of resiudal base
            yNewT <- yNewP +eps
            yAggi <- sum(yNewT)
        })
hist(res)
abline(v=yAgg, col="blue")
sd(res)/yAgg

#------------- bootstrap of the variance components
#i <- 1
yNewPop <- (fixef(mm1)["b0"]) * dsNew$dbh^( fixef(mm1)["b1"] )
sigma2 <- sigma0^2 * yNewPop^(2*delta)
varResid <- sum(sigma2)
res <- sapply( 1:nBoot, function(i){
            yNewFix <- (beta[i,"b0"]) * dsNew$dbh^(beta[i,"b1"])
            yNewRan <- (fixef(mm1)["b0"]+b0[i]) * dsNew$dbh^( fixef(mm1)["b1"] )
            yAggC <- c(varFix=sum(yNewFix), varRan=sum(yNewRan)) 
        })
varComp = c( apply( res, 1, var), varResid=varResid )
signif(varComp,3)
signif(varSumCompM[names(varComp)],3)       # compare to formula with n


hist(res)
abline(v=yAgg, col="blue")
sd(res)/yAgg


