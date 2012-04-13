source("inst/Performance/mergeSort1.R")
source("inst/Performance/mergeSort2.R")

set.seed(0815)
(m <- sample.int(500))
mySort(m)
mySort(m,fMerge=myMerge2)
mySort(m,fMerge=myMerge3)

library(profr)
n <- 10
p1 <- profr( {for( i in 1:n ) mySort(m)}, 0.02 )
plot(p1)

Rprof()
#for( i in 1:n ) mySort(m)
for( i in 1:n ) mySort2(m)
#for( i in 1:n ) mySort3(m)
Rprof(NULL)
summaryRprof()

Rprof()
for( i in 1:n ) mySort(m)
#for( i in 1:n ) mySort2(m)
#for( i in 1:n ) mySort3(m)
Rprof(NULL)
summaryRprof()


require(rbenchmark)
#benchmark( mySort(m), mySort(m,fMerge=myMerge2), mySort(m,fMerge=myMerge3), mySort2(m), replications=10)
benchmark( mySort(m), mySort2(m), sort(m), replications=10)
