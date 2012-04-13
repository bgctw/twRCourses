mySort <- function (m){
	# if list size is 1, consider it sorted and return it
	if( length(m) <= 1 ) return( m )
	# else list size is > 1, so split the list into two sublists
	middle = length(m) %/% 2
	left <- m[1:middle]
	right <- m[(middle+1):length(m)]
	# recursively call merge_sort() to further split each sublist
	# until sublist size is 1
	left = mySort(left)
	right = mySort(right)
	# merge the sublists returned from prior calls to merge_sort()
	# and return the resulting merged sublist
	#fMerge(left, right )
	#
	result <- numeric(0)
	while( length(left) > 0 || length(right) > 0){
		if( length(left) > 0 && length(right) > 0 ){
			if( left[1] <= right[1] ){
				result <- c(result, left[1] )
				left <- left[-1]
			}else{
				result = c(result, right[1] )
				right = right[-1]
			}
		}else if( length(left) > 0 ){
			result = c(result, left[1] )
			left <- left[-1]
		}else if( length(right) > 0){
			result = c(result, right[1] )
			right = right[-1]
		}
	}
	result
}

myMerge <- function(left, right){
	result <- numeric(0)
	while( length(left) > 0 || length(right) > 0){
		if( length(left) > 0 && length(right) > 0 ){
			if( left[1] <= right[1] ){
				result <- c(result, left[1] )
				left <- left[-1]
			}else{
				result = c(result, right[1] )
				right = right[-1]
			}
		}else if( length(left) > 0 ){
			result = c(result, left[1] )
			left <- left[-1]
		}else if( length(right) > 0){
			result = c(result, right[1] )
			right = right[-1]
		}
	}
	result
}
