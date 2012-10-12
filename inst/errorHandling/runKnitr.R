library(knitr)

tryCatch({
	prevWd <- setwd("inst/errorHandling")

	knitr::knit2html('RErrorHandling.Rmd')
	system("pandoc -t slidy --self-contained -s RErrorHandling.md -o RErrorHandlingSlides.html -ctwBlueR.css")
}
,finally=setwd(prevWd)
)