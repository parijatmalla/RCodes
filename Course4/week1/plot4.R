source('/media/sf_DataScience/RCodes/Course4/week1/plot1.R')
# function for plot 4

Plot4<-function()
{
	
	powerCons2007<-loadData()
	png("plot4.png",width=480,height=480)
	#Plot 1-Global Active Power
	par(mfrow=c(2,2))
	with(powerCons2007,{
		plot(x=powerCons2007$DateTime,y=powerCons2007$Global_active_power,type="l", ylab="Global Active Power ",xlab="")
	
				#plot 2- voltage
		plot(x=powerCons2007$DateTime,y=powerCons2007$Voltage,type="l", ylab="Voltage ",xlab="datetime")
	
			#Plot 3- Energy sub metering
		plot(x=powerCons2007$DateTime,y=powerCons2007$Sub_metering_1,type="l", col="black",ylab="Energy sub metering",xlab="")
		
		#add a line
		lines(x=powerCons2007$DateTime,y=powerCons2007$Sub_metering_2,type="l",col="red")
		lines(x=powerCons2007$DateTime,y=powerCons2007$Sub_metering_3,type="l",col="blue")
		
		#add legend
		legend("topright", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"),lwd=c(1,1,1))		
		
			#plot 4- global_reactive_power
		plot(x=powerCons2007$DateTime,y=powerCons2007$Global_reactive_power,type="l", ylab="Global_reactive_power ",xlab="datetime")
		
			})
	
	
	
#	dev.copy(png,"plot4.png",width=480,height=480)
	dev.off()
	
	
	
	
}
