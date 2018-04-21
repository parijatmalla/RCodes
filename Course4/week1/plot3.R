source('/media/sf_DataScience/RCodes/Course4/week1/plot1.R')

# function for plot 3

Plot3<-function()
{
	
	powerCons2007<-loadData()
	#Plot 3
	png("plot3.png",width=480,height=480)
	plot(x=powerCons2007$DateTime,y=powerCons2007$Sub_metering_1,type="l", col="black",ylab="Energy sub metering",xlab="")

#add a line
	lines(x=powerCons2007$DateTime,y=powerCons2007$Sub_metering_2,type="l",col="red")
	lines(x=powerCons2007$DateTime,y=powerCons2007$Sub_metering_3,type="l",col="blue")

#add legend
legend("topright", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"),lwd=c(1,1,1))	

	dev.off()
	
	
	
	
}