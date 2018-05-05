source('/media/sf_DataScience/RCodes/Course4/week4/plot1.R')

plot6<-function(){
	
	downloadData()
	#	file<-"/media/sf_DataScience/Course4/Source_Classification_Code.RDS"
	file<-"./Source_Classification_Code.RDS"
	
	sourceClassification<-readRDS(file,refhook=NULL)
	
	#file<-"/media/sf_DataScience/Course4/summarySCC_PM25.RDS"
	file<-"./summarySCC_PM25.RDS"
	
	summaryPM25<-readRDS(file,refhook=NULL)
	
	library(dplyr)
	
	#filter Baltimore City and California
	
	#used type=ON-ROAD for motor vehicles
	PM25For2Cities<-filter(summaryPM25,fips %in% c("24510","06037") & type=="ON-ROAD")
	
	
	motorEmission<-PM25For2Cities
	
	groupedData<-group_by(motorEmission,year,fips)
	totalEmissionMotor<-summarize(groupedData, TotalEmission=sum(Emissions))
	
	library(ggplot2)
	
	
	


	# to plot separate charts for each type
	
	#update fips with City name
totalEmissionMotor$fips[totalEmissionMotor$fips=="24510"]<-"Baltimore City , MD"
totalEmissionMotor$fips[totalEmissionMotor$fips=="06037"]<-"Los Angeles, California"
	
p0<-ggplot(data=totalEmissionMotor,aes(x=year,y=TotalEmission))+geom_bar(stat="identity",position = "stack")+ggtitle("Yearly Emission by Motor Vehicles")
	p0+facet_grid(.~totalEmissionMotor$fips)+labs(x="Year",y="Total Emission")+scale_x_continuous(breaks=c(1999,2002,2005,2008))
	
	ggsave("plot6.png",width=6,height=4)
	
	
}