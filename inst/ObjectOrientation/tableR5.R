# note: start up with an empty workspace void of the S4 Table object

Table <- setRefClass("Table", fields=list( 
		id="character", x = "numeric", y = "numeric"))

t1 <- Table$new(id="Table1", x=5, y=5)

# mutable
t1$x		# 5
t2 <- t1	# set a reference instead of copying
t2$x <- 8	
t1$x		# 8!!

# methods
Table$methods( move=function(dx=0,dy=0){
		'adds dx and dy to the coordinates'
		x <<- x + dx 
		y <<- y + dy 
	})
t1$move(0,-2); t1$y

# information on classes
Table$help()

# inheritance
SquareTable <- setRefClass("SquareTable", fields=list(sideLength="numeric")
	,contains="Table")
SquareTable$methods( calcArea = function(){ sideLength^2 })

s1 <- SquareTable$new(id="Table2", x=5, y=5, sideLength=2)
s1$calcArea()
s1$move(0,-3); s1$y

#initializers








