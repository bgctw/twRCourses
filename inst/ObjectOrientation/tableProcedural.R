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
