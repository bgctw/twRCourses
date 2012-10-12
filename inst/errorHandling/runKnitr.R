library(knitr)

tryCatch({
	prevWd <- setwd("inst/errorHandling")

	knitr::knit2html('RErrorHandling.Rmd')
	system("pandoc -t slidy --self-contained -s RErrorHandling.md -o RErrorHandlingSlides.html -ctwBlueR.css")
	
	#copy2clip(cmd <- "pandoc -t beamer -s RErrorHandling.md -o RErrorHandlingSlides.tex  -VfontsizeCode=\\\\fontnotesize -Vfontsize=10")
	#copy2clip(cmd <- "pandoc -t beamer -s RErrorHandling.md -o RErrorHandlingSlides.tex  --template=template_twutz10.tex -VfontsizeCode=\\footnotesize -Vfontsize=9")
	#copy2clip(cmd <- "pandoc -t beamer -s RErrorHandling.md -o RErrorHandlingSlides.tex -V theme:Rochester --template=template_twutz10.tex -VfontsizeCode=\\scriptsize -Vfontsize=9")
	copy2clip(cmd <- paste("pandoc -t beamer -s RErrorHandling.md -o RErrorHandlingSlides.tex"
		," --highlight-style=zenburn"
		," -V theme:Madrid -Vcolortheme:default "
		," --template=template_twutz10.tex -VfontsizeCode=\\footnotesize -Vfontsize=10pt"))
	# http://www.hartwork.org/beamer-theme-matrix/
	system(cmd)
	copy2clip(cmd <- "sed -i 's/includegraphics{/includegraphics[scale=0.5]{/g' RErrorHandlingSlides.tex")
	copy2clip(cmd <- "sed -i 's/\\\\begin{verbatim}/\\\\begin{block}{}\\n\\\\begin{verbatim}/g' RErrorHandlingSlides.tex")
	copy2clip(cmd <- "sed -i 's/\\\\end{verbatim}/\\\\end{block}\\n\\\\end{verbatim}/g' RErrorHandlingSlides.tex")
	system(cmd)	
	system("pdflatex RErrorHandlingSlides.tex")
	
	
	copy2clip(cmd <- "sed -i 's/documentclass.ignore/documentclass[10pt,ignore/g' RErrorHandlingSlides.tex")
	system(cmd)	
	copy2clip(cmd <- "sed -i 's/\\DefineVerbatim/\\\\makeatletter \\\\g@addto@macro\\\\@verbatim\\\\footnotesize \\\\makeatother\\n\\\\DefineVerbatim/g' RErrorHandlingSlides.tex")
	system(cmd)
	copy2clip(cmd <- "sed -i 's/DefineVerbatim*}$/DefineVerbatim,fontsize=\\footnotesize}/g' RErrorHandlingSlides.tex")
	system(cmd)
	
}
,finally=setwd(prevWd)
)