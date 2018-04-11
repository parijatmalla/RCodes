## The purpose of this script is to collect and read data from UCI 
# and generate tidy data set from it

extractData<-function (){

	url<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
	zip_file <- file.path(getwd(), "getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip")

	
	f<-"./UCI HAR Dataset"
	uci_zipfile<-".UCI_HAR_Dataset"
	
	if (!file.exists(f)) {
		message("Directory does not exist already. Downloading and extracting")
		download.file(url, zip_file, mode = "wb")
		unzip("getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", overwrite=TRUE)
	}
	if(file.exists(f)) {
	message ("File already exists!")
	
	}
}


## function to load data from files 
loadFiles<-function(){
#	UCI_directory<-"./UCI.HAR.Dataset/"
	file<-"./UCI HAR Dataset/features.txt"
	colnames<-c("featureID","feature_desc")
	
	# read feature.txt and save it into variable feature
	features<-read.table(file,header=FALSE, sep="",col.names=colnames)
	message("Read feature.txt",names(features))
	
	# read activity_labels.txt #
	file<-"./UCI HAR Dataset/activity_labels.txt"
	colnames<-c("activityID","activityDesc")	
	activities<-read.table(file,header=FALSE, sep="",col.names=colnames)
	message("Read activity_labels.txt")
	
	# read training data set
	file<-"./UCI HAR Dataset/train/X_train.txt"
	colnames<-features$feature_desc
	training_set<-read.table(file,header=FALSE, sep="",col.names=colnames)	
	message("Read X_train.txt")
	
	# extract only the data on mean and standard deviation
	library(dplyr)
	
	train_mean_std<-select (training_set,grep("mean[[:punct:]]|std[[:punct:]]",names(training_set)))
	message("Selecting only mean and std data")
	
	
	#read training labels
	file<-"./UCI HAR Dataset/train/y_train.txt"
	colnames<-c("activityID")
	training_labels<-read.table(file,header=FALSE, sep="",col.names=colnames)	
	message("Read y_train.txt")
	
	#add training labels as a column to training set
	training<-cbind(train_mean_std,training_labels)
	message("Add activityID to training data")
	
	# add subject info for training set
	file<-"./UCI HAR Dataset/train/subject_train.txt"
	colnames<-c("subjectID")
	training$subjectID<-as.integer( read.table(file,header=FALSE, sep="",col.names=colnames)[,1])
	message("Add subjectID to training data")

	# read test  data set
	file<-"./UCI HAR Dataset/test/X_test.txt"
	colnames<-features$feature_desc
	test_set<-read.table(file,header=FALSE, sep="",col.names=colnames)	
	message("Read X_test.txt")
	
	#select only mean and standard deviation
	test_mean_std<-select (test_set,grep("mean[[:punct:]]|std[[:punct:]]",names(test_set)))
	
		
	#read test labels
	file<-"./UCI HAR Dataset/test/y_test.txt"
	colnames<-c("activityID")
	test_labels<-read.table(file,header=FALSE, sep="",col.names=colnames)	
	message("Read y_test.txt")
	
	
	#add test labels as a column to training set
	test<-cbind(test_mean_std,test_labels)
	message("Add activityID to test data")
	
	# add subject info for test set
	file<-"./UCI HAR Dataset/test/subject_test.txt"
	colnames<-c("subjectID")
	test$subjectID<-as.integer(read.table(file,header=FALSE, sep="",col.names=colnames)[,1])
	message("Add subjectID to test data")
	
	# add activity labels in the training and test data set
	
	testData<-merge(test,activities,by.x="activityID",by.y="activityID")
	message("Add activity_desc to test data")
	
	trainingData<-merge(training,activities,by.x="activityID",by.y="activityID")
	message("Add activity_desc to training data")
	
	# merge test data and training data
merged_data<-rbind(trainingData,testData)
	message("Merging test and training data") 
	

return(merged_data)
	
		

	

}

# function that is used to save data to file
save_data <- function (clean_data, file_name) {
	write.table(clean_data, file = file_name, row.names = FALSE)
}

## function to generate clean data
cleanData<-function(merged_data){
	message("Cleaning data...")
	labels<-colnames(merged_data)
	# replace time in the name for 't'
labels<-	gsub("^t", "time", labels)
labels<-gsub("^f", "frequency", labels)
labels<-gsub("[[:punct:]]","",labels)
labels<-gsub("mean","Mean",labels)
labels<-gsub("std","StdDev",labels)
labels<-gsub("BodyBody","Body",labels)
labels<-gsub("Mag","Magnitude",labels)
colnames(merged_data)<-labels
if (!file.exists("./data")) {
	message("Directory data not found. Creating ./data directory")
	dir.create("./data")
}

save_data(merged_data,"./data/tidy_data.txt")
#grouped_data<-merged_data %>%
#	group_by(subjectID, activityDesc) %>%
#	summarize(AvgtimeBodyAccMeanX=mean(timeBodyAccMeanX))
message("Aggregating data..")
grouped_data<-aggregate(merged_data[, 2:ncol(merged_data)-2],list(subjectID=merged_data$subjectID,activityDesc= merged_data$activityDesc), mean)
save_data(grouped_data,"./data/aggregate_UCI_mean_tidy_data.txt")
}

run_analysis<-function(){
	extractData()
	merged_data<-loadFiles()
	cleanData(merged_data)
}
