
check_table <- function(object){ length(object@x)==1 && length(object@y)==1 }

setClass("Table", representation( 
		id="character", x = "numeric", y = "numeric")
	,validity=check_table)

t1 <- new("Table", id="Table1", x=5, y=5)

# automatic checking and validation
t2 <- new("Table", id="Table1", x="five", y=5)	# wrong type
t2 <- new("Table", id="Table1", x=1:2, y=5)		# length(x)!=1 

# slots (properties)
getSlots("Table")
t1@id 
slot(t1,"id")

# methods
setGeneric("calcArea", function(x, ...){ standardGeneric("calcArea") })
setGeneric("move", function(x,dx,dy,...){ standardGeneric("move") })
setMethod("move",signature(x="Table",dx="numeric",dy="numeric"), function(x,dx=0,dy=0){
		x@x = x@x + dx
		x@y = x@y + dy
		x
	})
t2 <- move(t1,2,0); t2@x

# information on classes
showMethods("move")

# inheritance
setClass("SquareTable",representation(sideLength="numeric")
	, contains ="Table"	)
setMethod("calcArea",signature("SquareTable"), function(x){	x@sideLength^2 })
s1 <- new("SquareTable", id="Table2", x=5, y=5, sideLength=2)
calcArea(s1)

s2 <- move(s1,3,3); s2@x







