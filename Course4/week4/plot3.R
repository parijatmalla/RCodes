source('/media/sf_DataScience/RCodes/Course4/week4/plot1.R')

plot3<-function(){
	
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
	groupedData<-group_by(EmissionBaltimore,year,type)
	totalEmissionBySrc<-summarize(groupedData, TotalEmission=sum(Emissions))
	
	library(ggplot2)

# to plot separate charts for each type
#	p0<-ggplot(data=totalEmissionBySrc,aes(x=year,y=TotalEmission))+geom_bar(stat="identity",position = "stack")+ggtitle("Yearly Emission by Type for Baltimore City")
#p0+facet_grid(.~totalEmissionBySrc$type)+labs(x="Year")+scale_x_continuous(breaks=c(2000,2002,2004,2006,2008))

	#line graph with 4 types
p1<-ggplot(data=totalEmissionBySrc,aes(x=year,y=TotalEmission))+geom_line(aes(color=type))+ggtitle("Yearly Emission by Type for Baltimore City")+labs(x="Year",y="Total Emission")

	
ggsave("plot3.png",width=9,height=4)
#	dev.off()
	
}