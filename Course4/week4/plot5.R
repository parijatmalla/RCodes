source('/media/sf_DataScience/RCodes/Course4/week4/plot1.R')

plot5<-function(){
	
	downloadData()
	#	file<-"/media/sf_DataScience/Course4/Source_Classification_Code.RDS"
	file<-"./Source_Classification_Code.RDS"
	
	sourceClassification<-readRDS(file,refhook=NULL)
	
	#file<-"/media/sf_DataScience/Course4/summarySCC_PM25.RDS"
	file<-"./summarySCC_PM25.RDS"
	
	summaryPM25<-readRDS(file,refhook=NULL)
	
	library(dplyr)
	
	#filter only Baltimore City's data
	#motor vehicle related emissions 
	#using Short.Name with %motor% resulted in very low values so used type=ON-ROAD
	BaltimorePM25<-filter(summaryPM25,fips=="24510" & type=="ON-ROAD")
	
	#merge Baltimore's summary info and SCC info
	mergedData<-merge(BaltimorePM25,sourceClassification,by="SCC")
	
	#if using Short.Name with %motor% 
	#motorEmission<-mergedData[grep("motor",mergedData$Short.Name,ignore.case=TRUE),]
	motorEmission<-mergedData
	
	groupedData<-group_by(motorEmission,year)
	totalEmissionMotor<-summarize(groupedData, TotalEmission=sum(Emissions))
	
	library(ggplot2)
	

	
	p1<-ggplot(data=totalEmissionMotor,aes(x=year,y=TotalEmission))+geom_bar(stat="identity",position = "stack")+ggtitle("Yearly Emission by Motor Vehicles in Baltimore City ")+labs(x="Year",y="Total Emission ")+scale_x_continuous(breaks=c(1999,2002,2005,2008))
	
	
	ggsave("plot5.png",width=6,height=4)

	
}