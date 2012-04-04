# proramming support for tables
# based on http://programmersnotes.info/2009/02/28/what-is-oop-object-oriented-programming/ 

# task print a list of tables including its area

#----- procedural approach 
calcSquare <- function(sideLength){
	sideLength*sideLength
}
calcTriangle <- function(sideLength){
	sideLength*sideLength/2
}
calcCircle <- function(radius){
	base::pi * radius * radius 
}

tables <- data.frame( id=c("Table1","Table2","Table3","Table4")
	, type=c("square","square","circle","triangle")
	, size=c(3,4,2,3)
)

# calculate the square
area <- numeric( nrow(tables) )
#i <- 1
for( i in 1:nrow(tables) ){
	type <- tables[i,"type"]	
	size <- tables[i,"size"]
	area[i] <- 
		if( type == "square" ) calcSquare(size) else 
		if( type == "circle" ) calcCircle(size) else 
		if( type == "triangle" ) calcTriangle(size)  
}
area

#---------- OO approach
calcArea <- function(x, ...) UseMethod("calcArea", x)
calcArea.SquareTable <- function(x){ 	x$sideLength*x$sideLength }
calcArea.TriangleTable <- function(x){	x$sideLength*x$sideLength/2 }
calcArea.CircleTable <- function(x){	base::pi * x$radius * x$radius }

new_SquareTable <- function(id,sideLength=1){ 
	structure( list(id=id, sideLength=sideLength), class="SquareTable" )}
new_TriangleTable <- function(id,sideLength=1){ 
	structure( list(id=id, sideLength=sideLength), class="TriangleTable" )}
new_CircleTable <- function(id,radius=1){ 
	structure( list(id=id, radius=radius), class="CircleTable" )}

tablesO <- list( 
	new_SquareTable("Table1",sideLength=3)
	,new_SquareTable("Table2",4)
	,new_CircleTable("Table3",radius=2)
	,new_TriangleTable("Table4")
)
(areas <- sapply(tablesO, calcArea))





