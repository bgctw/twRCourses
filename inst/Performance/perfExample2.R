#Consider the problem of finding the distribution of the
#determinant of a 2 x 2 matrix where the entries are
#independent and uniformly distributed digits 0, 1, : : :, 9. This
#amounts to finding all possible values of ac  bd where a, b,
#c and d are digits.

dd.for.c <- function() {
	val <- NULL
	for (a in 0:9) 
		for (b in 0:9) 
			for (d in 0:9) 
				for (e in 0:9)
					val <- c(val, a*b - d*e)
	table(val)
}
mean(replicate(10, system.time(dd.for.c())["elapsed"]))


dd.fast.tabulate <- function() {
	val <- outer(0:9, 0:9, "*")
	val <- outer(val, val, "-")
	tabulate(val)
}
mean(replicate(10, system.time(dd.fast.tabulate())["elapsed"]))

