userError <- function(
	### generates an error of given class
	class="userError"	##<< scalar character string: the class of the error 
	, message			##<< error msg 
	, call=NULL			##<< call expression.
){
	##details<< 
	## in order to distinguish different kinds of error
	classList <- c(class, "error", "condition")
	structure(list(message = as.character(message), call = call), 
			class = classList)
	### list of class class with entries message and call
}
attr(userError,"ex") <- function(){
	
}

res <- tryCatch({
	#warning("warning1")
	stop(
		userError("parError")
		#userError("parError","first argument must be a scalar")
	)
	5
}
,parError=function(e){ 
	cat("In userError2 handler\n"); 
	print(e$message)
	return(1)
}
,error=function(e){
	cat("In error handler\n")
	str(e)
}
,warning=function(e){
	#recover()
})