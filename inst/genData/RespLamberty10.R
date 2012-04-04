# generating example dataset respLamberty10

ds <- read.csv(file.path("inst","genData","Bond-Lamberty10_nature08930-s2.txt"))
ds$Study <- as.factor(ds$Study)
str(ds)
RespLamberty10 <- ds[,c("Study","Rs_annual","LU_AT")]
names(RespLamberty10) <-  c("Study","resp","temp")
plot( resp~temp, col=Study, data=RespLamberty10)

save( RespLamberty10, file=file.path("data","RespLamberty10.RData") )

# adjust documentation in RespLamberty10.RD

