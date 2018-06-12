# Data Vis Turotial
# Thomas Wutzler
# 161202
# Intro to colour and ggplot2
#
# examples for clean theme at the bottom

#rm(list=ls())
library(ggplot2)
library(Hmisc)
library(RColorBrewer)

# Using nice colour palettes
display.brewer.all(type="qual")
display.brewer.pal(5,"Set2")
colCodes = brewer.pal(5,"Set2")

display.brewer.all(type="seq")
display.brewer.pal(3,"Blues")
colCodes = brewer.pal(3,"Blues")

#data
str(mtcars)

# ggplot
# Univariate histogram
ggplot(mtcars,aes(mpg)) +
  geom_histogram(aes(y=..density..), binwidth=1)

# bi/multivariate scatterplot
ggplot(mtcars,aes(wt,mpg)) +
  geom_point()


# Aesthetics MAP variables onto visible scales
# Attributes SET how a visible scale looks
# They use the same names
# Attributes will override aesthetics
ggplot(mtcars,aes(wt,mpg, col=factor(cyl))) +
  #geom_point(shape=1)  # hollow circles 
  #geom_point(alpha=0.6, size=8)            # default 19: circle with outline
  geom_point(alpha=0.6, size=8, shape=16) # circle without outline


# Using positions: i.e. with bar bar plot
cyl.am <- ggplot(mtcars, aes(factor(cyl), fill=factor(am)))
cyl.am + geom_bar()                   # default stacked
cyl.am + geom_bar(position="dodge")   # side by side
cyl.am + geom_bar(position="fill")    # proportions
cyl.am + geom_bar(position="identity", alpha=0.6)    # in front of each other

# Modifying the aesthetics, i.e. setting the scales
cyl.amd <- cyl.am + geom_bar(position="dodge")   # side by side
cyl.amd + scale_fill_brewer(palette="Dark2")
cyl.amd + scale_fill_manual("Transmission\ntype", values=colCodes)
# combine hue and 2 levels of brightness
#    with combined alternating factor levels
#   cyl.amd + scale_fill_brewer(palette="Pairs")  
cyl.amd + scale_y_continuous(breaks=seq(0,12,2)) # remove tick labels
cyl.amd + scale_y_continuous(expand = c(0,0))    # remove edge around axis
cyl.amd + scale_y_continuous(limits = c(0,16))   # set axis range
cyl.amd + scale_x_discrete("Number of cylinders")   # axis label


#----------- The fourth layer: Statistic
# add a model
mpg.wt <- ggplot(mtcars, aes(wt, mpg)) + geom_point()
mpg.wt + stat_smooth()
mpg.wt + stat_smooth(span=1.2)  # smoother than default
mpg.wt + stat_smooth(se=FALSE)  # omit uncertainty ribbon
mpg.wt + stat_smooth(se=FALSE) + stat_smooth(method="lm", col="darkred")  

# get the legend by wrap them into aes
mpg.wt + stat_smooth(method="loess", se=FALSE, aes(col="loess")) +
  stat_smooth(method="lm", aes(col="LM")) +  
  scale_color_brewer("Model", palette="Set1")

#--- calculate summary statistics
# clean up data
mtcars$cyl <- as.factor(mtcars$cyl)
mtcars$am <- as.factor(mtcars$am)
levels(mtcars$am) <- c("Automatic","Manual")
str(mtcars)
# define positions
pos.dodge <- position_dodge(width=0.4)
pos.jitter <- position_jitter(width=0.2)
pos.jitterdodge <- position_jitterdodge(jitter.width=0.2, dodge.width = 0.4)
wt.cyl.am <- ggplot(mtcars, aes(cyl,wt,col=am))
wt.cyl.am + geom_point(position=pos.jitter)
wt.cyl.am + geom_point(position=pos.jitterdodge)

# descriptive statistics
# see Hmisc mean_sdl and mean_cl_normal
desc <- wt.cyl.am + stat_summary(fun.data=mean_sdl, fun.args=list(mult=1), position=pos.dodge)
desc
# inferential statistics
wt.cyl.am + stat_summary(fun.data=mean_cl_normal, position=pos.dodge)


#--------- The fifth layer: coordinates
desc
#!attention: filters data before calculating statistics
# heed the warning message
desc + scale_y_continuous(limits=c(1,5))

# coord zoom in, but don't filter
desc + coord_cartesian(ylim=c(1,5))


#---------- the sixth layer: facets
mpg.wt <- ggplot(mtcars, aes(wt, mpg, col=cyl)) + geom_point()
mpg.wt + facet_grid( . ~ am)


#--------- The seventh layer: Themes, all non-data ink
mpg.wt <- ggplot(mtcars, aes(wt, mpg, col=cyl)) + geom_point() + facet_grid( . ~ am)
mpg.wt + theme_bw()
mpg.wt + theme_classic()
mpg.wt + theme_classic() + scale_y_continuous(breaks=c(10,20,30), expand = c(0,0)) +
  theme(strip.background = element_blank()) + # remove the 
  #theme(axis.line= element_blank(), axis.ticks = element_blank()) +
  theme(axis.line= element_blank()) +
  theme(panel.grid.major.y=element_line(colour="grey75")) +
  coord_cartesian(ylim=c(10,35))
  geom_segment(x=2, xend=5, y=10, yend = 10, col="black")
  c()
  
  
geom_rug()  
mpg.wt + theme_classic() + theme(legend.position=c(0.9,0.8))
theme( axis.l)

ggsave("myPlot.pdf")

.tmp.f <- function(){
	ggplot(mtcars, aes(mpg, hp)) + geom_point() +
			facet_wrap(~carb, ncol = 3) + theme_bw() +
			theme_classic() +
			theme(strip.background = element_blank()) + 
			theme(panel.border = element_rect(colour = "black", fill=NA)) +
			theme(panel.grid.major = element_blank(),
					panel.grid.minor = element_blank(),
					strip.background = element_blank(),
					panel.border = element_rect(colour = "black")) +
			c()
}

.tmp.f <- function(){
	#http://stackoverflow.com/questions/38986702/add-tick-marks-to-facet-plots-in-r
	# adding axis lines to plots by hand
	ggplot(mtcars, aes(mpg, hp)) + 
			geom_point() + 
			facet_wrap(~carb) +
			theme_classic() +
			annotate("segment", x=-Inf, xend=Inf, y=-Inf, yend=-Inf)+
			annotate("segment", x=-Inf, xend=-Inf, y=-Inf, yend=Inf)
}

.tmp.f <- function(){
	#http://stackoverflow.com/questions/22116518/add-x-and-y-axis-to-all-facet-wrap
	# answer by Didzis Elferts
	# not supported yet http://scarff.id.au/blog/2010/duplicating-ggplot-axis-labels/
	p1<-ggplot(mtcars, aes(mpg, hp)) + 
			geom_point() + 
			facet_wrap(~carb) +
			theme_classic() +
			c()
	p1Mod <- p1 + theme_bw()
			theme(panel.grid = element_blank(),
					panel.background = element_blank(), 
					panel.border = element_blank(), 
					axis.line = element_line(),
					strip.background = element_blank(),
					panel.margin = unit(2, "lines"))
	
	p2<-ggplot(mtcars, aes(mpg, hp)) + 
			geom_point() + 
			facet_wrap(~carb) +
			theme(panel.grid = element_blank(),
					panel.background = element_blank(), 
					panel.border = element_blank(), 
					axis.line = element_line(),
					strip.background = element_blank(),
					panel.margin = unit(2, "lines"),
					axis.ticks=element_blank(),
					axis.text=element_blank())	
}
  
  
