source('/media/sf_DataScience/RCodes/Course4/week4/plot1.R')

plot2<-function(){

	downloadData()
	#	file<-"/media/sf_DataScience/Course4/Source_Classification_Code.RDS"
	file<-"./Source_Classification_Code.RDS"

	
	
	sourceClassification<-readRDS(file,refhook=NULL)
	
	#file<-"/media/sf_DataScience/Course4/summarySCC_PM25.RDS"
	file<-"./summarySCC_PM25.RDS"
	
	summaryPM25<-readRDS(file,refhook=NULL)
	
	library(dplyr)
	
	# get total emissions from different sources for each yearfor Baltimore city (fips=="24510")
	
	EmissionBaltimore<-filter(summaryPM25,fips=="24510")
	groupedData<-group_by(EmissionBaltimore,year)
	totalEmissionBySrc<-summarize(groupedData, TotalEmission=sum(Emissions))
	
	library(datasets)
	totalEmissionBySrc$TotalEmission
	
	#save the plot to PNG
	png("plot2.png",width=480,height=480)
	
	#bar plot showing total emissions each year
	barplot(names=totalEmissionBySrc$year,height=totalEmissionBySrc$TotalEmission,xlab="Year",ylab="Total Emissions",main="Yearly Total PM2.5 emissions in Baltimore")
	
	
	dev.off()
	
}