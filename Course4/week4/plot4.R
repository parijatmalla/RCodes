source('/media/sf_DataScience/RCodes/Course4/week4/plot1.R')

plot4<-function(){
	
	downloadData()
	#	file<-"/media/sf_DataScience/Course4/Source_Classification_Code.RDS"
	file<-"./Source_Classification_Code.RDS"
	
	sourceClassification<-readRDS(file,refhook=NULL)
	
	#file<-"/media/sf_DataScience/Course4/summarySCC_PM25.RDS"
	file<-"./summarySCC_PM25.RDS"
	
	summaryPM25<-readRDS(file,refhook=NULL)
	
	library(dplyr)
	
	#merge summary info and SCC info
	mergedData<-merge(summaryPM25,sourceClassification,by="SCC")
	
	#coal combustion related emissions using Short.Name with %coal%
	
	coalEmission<-mergedData[grep("coal",mergedData$Short.Name,ignore.case=TRUE),]
	
	groupedData<-group_by(coalEmission,year)
	totalEmissionCoal<-summarize(groupedData, TotalEmission=sum(Emissions)/100000)
	
	library(ggplot2)
	

	
	#bar graph 
	p1<-ggplot(data=totalEmissionCoal,aes(x=year,y=TotalEmission))+geom_bar(stat="identity",position = "stack")+ggtitle("Yearly Emission by Coal Combustion ")+labs(x="Year",y="Total Emission (10^5)")+scale_x_continuous(breaks=c(1999,2002,2005,2008))
	
	
	ggsave("plot4.png",width=6,height=4)
	#	dev.off()
	
}