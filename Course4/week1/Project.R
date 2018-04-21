Plots<-function()
	{
	file<-"./Course4/week1/household_power_consumption/household_power_consumption.txt"
#colnames<-c("featureID","feature_desc")

# read feature.txt and save it into variable feature
powerConsumption<-read.table(file,header=TRUE, sep=";",na.strings="?")

# change data type to date and time
powerConsumption$Date<-as.Date(powerConsumption$Date,format="%d/%m/%Y")
powerConsumption$DateTime<-paste(powerConsumption$Date,powerConsumption$Time)
powerConsumption$DateTime<-strptime(powerConsumption$DateTime,format="%Y-%m-%d %H:%M:%S")

#subset data for 2007-02-01 and 2007-02-02
powerCons2007<-subset(powerConsumption,as.Date(powerConsumption$Date) >=as.Date("2007-02-01") & as.Date(powerConsumption$Date)<=as.Date("2007-02-02") )


#change Global_active_power to numeric data type
powerCons2007$Global_active_power<-as.numeric(powerCons2007$Global_active_power)

#Plot 1
hist(powerCons2007$Global_active_power,col="red",main="Global Active Power",xlab="Global Active Power(kilowatts)",ylab="Frequency")
dev.copy(png,"plot1.png",width=480,height=480)

#Plot 2


dev.off()
return (powerCons2007)
}