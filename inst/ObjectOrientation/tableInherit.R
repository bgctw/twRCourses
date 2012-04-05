# adding a superclass Table to all the different tables
# that holds coordinates x and y and can be printed and moved

new_SquareTable <- function(id,sideLength=1, x=5, y=5){ 
	structure( list(id=id, sideLength=sideLength, x=x, y=y), class=c("SquareTable","Table") )}
new_TriangleTable <- function(id,sideLength=1, x=5, y=5){ 
	structure( list(id=id, sideLength=sideLength, x=x, y=y), class=c("TriangleTable","Table") )}
new_CircleTable <- function(id,radius=1, x=5, y=5){ 
	structure( list(id=id, radius=radius, x=x, y=y), class=c("CircleTable","Table") )}

print.Table <- function(x){
	print(paste(x$id," of class ",class(x)[1]," with (x,y)=(", 
			paste( signif(c(x$x,x$y),2), collapse=","),")",sep=""))} 
(t1 <- new_SquareTable("Table1"))

move <- function(x, ...) UseMethod("move", x)
move.Table <- function(x, dx=0, dy=0){ 	
	x$x <- x$x + dx
	x$y <- x$y + dy
	x
}
(t2 <- move(t1,3,0))


tablesO <- list( 
	new_SquareTable("Table1",sideLength=3)
	,new_SquareTable("Table2",4)
	,new_CircleTable("Table3",radius=2)
	,new_TriangleTable("Table4")
)
print(tablesO)

tablesO2 <- lapply(tablesO, move, dx=3)
print(tablesO2)