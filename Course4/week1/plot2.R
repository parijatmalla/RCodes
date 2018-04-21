source('/media/sf_DataScience/RCodes/Course4/week1/plot1.R')

# function for plot 2

Plot2<-function()
{
	
	powerCons2007<-loadData()
	#Plot 2
	plot(x=powerCons2007$DateTime,y=powerCons2007$Global_active_power,type="l", ylab="Global Active Power (kilowatts)",xlab="")
	dev.copy(png,"plot2.png",width=480,height=480)
	dev.off()
	
	
	
	
}