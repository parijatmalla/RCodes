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
#	activity<-read.csv(file,header=TRUE, sep=",")
#return (activity)
}

plotHist<-function()
{
	readData()
	
	file<-"./activity.csv"
	activityNA<-read.csv(file,header=TRUE, sep=",",stringsAsFactors=FALSE)
	activity<-activityNA[with(activityNA,{!(is.na(steps))}),]
	#	data_row[ with (data_row, { !(is.na(steps)) } ), ]
	
	activity$date<-as.Date(activity$date,format="%Y-%m-%d")
	
	library(dplyr)
	
	#group by date
	groupedData<-group_by(activity,date)
	
	#get the total steps in a day
	s<-summarize(groupedData,steps=sum(steps))
	

	hist(s$steps,main="Histogram of Total Steps per Day",xlab="Steps Per Day")

	groupedData<-group_by(activity,interval)
	mean_steps<-summarize(groupedData, steps=mean(steps))
	
	activityOnlyNA<-activityNA[with(activityNA,{(is.na(steps))}),]
	activityOnlyNA<-select(activityOnlyNA,interval,date)
	imputedData<-merge(activityOnlyNA,mean_steps,by.x="interval", by.y="interval")
	imputedData<-data.frame(select(imputedData, steps,date,interval),stringsAsFactors = FALSE)
	activity<-data.frame(select(activity,steps,date,interval),stringsAsFactors = FALSE)
	imputedData$date<-as.Date(imputedData$date,format="%Y-%m-%d")
	activityImputed<-rbind(imputedData,activity)
	c<-class(activityImputed$date)
	activityImputed$date<-as.Date(activityImputed$date,format="%Y-%m-%d")
	
x<-mutate(activityImputed,Dayofweek=weekdays(as.Date(date)))
a<- filter(activityImputed,weekdays(as.Date(date)) %in% c("Saturday","Sunday") )
#	nrow(a)
	a<-mutate(a,Dayofweek ="Weekend") 
	
	#aa<- filter(activity,weekdays(as.Date(date)) %in% c("Saturday","Sunday") )
#	nrow(aa)
#	aa<-mutate(aa,Dayofweek ="Weekend") 
	
	b<- filter(activityImputed,!(weekdays(date) %in% c("Saturday","Sunday") ))
b<-mutate(b,Dayofweek ="Weekday") 
	
	
	
	z<-nrow(a)
nrow(b)
	return(activityImputed)
}