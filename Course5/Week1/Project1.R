readData<-function (){
	url<-"https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2Factivity.zip"
	zip_file <- file.path(getwd(), "repdata%2Fdata%2Factivity.zip")
	
	
	f<-"./activity.csv"
	uci_zipfile<-".repdata%2Fdata%2Factivity"
	
	if (!file.exists(f)) {
		message("Directory does not exist already. Downloading and extracting")
		download.file(url, zip_file, mode = "wb")
		unzip("repdata%2Fdata%2Factivity.zip", overwrite=TRUE)
	}
	if(file.exists(f)) {
		message ("File already exists!")
		
	}
	file<-"./activity.csv"
	activity<-read.csv(file,header=TRUE, sep=",")
return (activity)
}

plotHist<-function()
{
	readData()
	
	file<-"./activity.csv"
	activity<-read.csv(file,header=TRUE, sep=",")
	activity<-activity[with(activity,{!(is.na(steps))}),]
	#	data_row[ with (data_row, { !(is.na(steps)) } ), ]
	
	activity$date<-as.Date(activity$date,format="%Y-%m-%d")
	
	library(dplyr)
	
	#group by date
	groupedData<-group_by(activity,date)
	
	#get the total steps in a day
	s<-summarize(groupedData,steps=sum(steps))
	

	hist(s$steps,main="Histogram of Total Steps per Day",xlab="Steps Per Day")

}