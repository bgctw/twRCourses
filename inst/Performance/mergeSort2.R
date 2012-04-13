
myMerge2 <- function(left, right){
	result <- numeric( length(left)+length(right) )
	ir <- 1
	while( length(left) > 0 || length(right) > 0){
		if( length(left) > 0 && length(right) > 0 ){
			if( left[1] <= right[1] ){
				result[ir] <- left[1]
				left <- left[-1]
			}else{
				result[ir] <- right[1]
				right = right[-1]
			}
		}else if( length(left) > 0 ){
			result[ir] <- left[1]
			left <- left[-1]
		}else if( length(right) > 0){
			result[ir] <- right[1]
			right = right[-1]
		}
		ir = ir+1
	}
	result
}

myMerge3 <- function(left, right){
	result <- numeric( length(left)+length(right) )
	return(result)
}

myMerge4 <- function(left, right){
	left
}

mySort2a <- function (m, fMerge=myMerge){
	# if list size is 1, consider it sorted and return it
	if( length(m) <= 1 ) return( m )
	# else list size is > 1, so split the list into two sublists
	middle = length(m) %/% 2
	left <- m[1:middle]
	right <- m[(middle+1):length(m)]
	# recursively call merge_sort() to further split each sublist
	# until sublist size is 1
	left = mySort2a(left)
	right = mySort2a(right)
	# merge the sublists returned from prior calls to merge_sort()
	# and return the resulting merged sublist
	c(left, right )
}

mySort3 <- function (m, fMerge=myMerge){
	# if list size is 1, consider it sorted and return it
	if( length(m) <= 1 ) return( m )
	# else list size is > 1, so split the list into two sublists
	middle = length(m) %/% 2
	left <- m[1:middle]
	right <- m[(middle+1):length(m)]
	# recursively call merge_sort() to further split each sublist
	# until sublist size is 1
	left = mySort3(left)
	right = mySort3(right)
	# merge the sublists returned from prior calls to merge_sort()
	# and return the resulting merged sublist
	myMerge2(left, right )
}

mySort2 <- function (m){
	# if list size is 1, consider it sorted and return it
	if( length(m) <= 1 ) return( m )
	# else list size is > 1, so split the list into two sublists
	middle = length(m) %/% 2
	left <- m[1:middle]
	right <- m[(middle+1):length(m)]
	# recursively call merge_sort() to further split each sublist
	# until sublist size is 1
	left = mySort2(left)
	right = mySort2(right)
	# merge the sublists returned from prior calls to merge_sort()
	# and return the resulting merged sublist
	#fMerge(left, right )
	#
	result <- numeric( length(left)+length(right) )
	ir <- 1
	while( length(left) > 0 || length(right) > 0){
		if( length(left) > 0 && length(right) > 0 ){
			if( left[1] <= right[1] ){
				result[ir] <- left[1]
				left <- left[-1]
			}else{
				result[ir] <- right[1]
				right = right[-1]
			}
		}else if( length(left) > 0 ){
			result[ir] <- left[1]
			left <- left[-1]
		}else if( length(right) > 0){
			result[ir] <- right[1]
			right = right[-1]
		}
		ir = ir+1
	}
	result
}
