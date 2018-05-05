downloadData<-function (){
	
	url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
	zip_file <- file.path(getwd(), "exdata%2Fdata%2FNEI_data.zip")
	
	
	f<-"./summarySCC_PM25.rds"
	nei_zipfile<-".exdata%2Fdata%2FNEI_data"
	
	if (!file.exists(f)) {
		message("Directory does not exist already. Downloading and extracting")
		download.file(url, zip_file, mode = "wb")
		unzip("exdata%2Fdata%2FNEI_data.zip", overwrite=TRUE)
		message ("Unzipping the file...")
	}
	if(file.exists(f)) {
		message ("File already exists!")
		
	}
	

}

plot1<-function(){
	downloadData()
#	file<-"/media/sf_DataScience/Course4/Source_Classification_Code.RDS"
	file<-"./Source_Classification_Code.RDS"



sourceClassification<-readRDS(file,refhook=NULL)

#file<-"/media/sf_DataScience/Course4/summarySCC_PM25.RDS"
file<-"./summarySCC_PM25.RDS"

summaryPM25<-readRDS(file,refhook=NULL)

library(dplyr)

# get total emissions from different sources for each year

groupedData<-group_by(summaryPM25,year)
totalEmissionBySrc<-summarize(groupedData, TotalEmissionTon=sum(Emissions)/1000000)

library(datasets)
totalEmissionBySrc$TotalEmissionTon

#save the plot to PNG
png("plot1.png",width=480,height=480)

#bar plot showing total emissions each year
barplot(names=totalEmissionBySrc$year,height=totalEmissionBySrc$TotalEmissionTon,xlab="Year",type="h",ylab="Total Emissions in ton (10^6)",main="Yearly Total PM2.5 emissions")


dev.off()
	
}