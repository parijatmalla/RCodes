# Getting and Cleaning Data

The directory contains R script to:

- Read the UCI data
- Merge the training and the test sets to create one data set.
- Extract only the measurements on the mean and standard deviation for each measurement.
- Use descriptive activity names to name the activities in the data set
- Appropriately label the data set with descriptive variable names.
- Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

##Steps to run:
Run the script run_analysis.R


##Details of run_analysis.R

extractData() - This is a function to download the UCI file and unzip it.

loadFiles() - This is a function to load the UCI data and merge training data with test dataset:

- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.
- 'activity_labels.txt': Links the class labels with their activity name.
- 'train/X_train.txt': Training set.
- 'train/y_train.txt': Training labels.
- 'test/X_test.txt': Test set.
- 'test/y_test.txt': Test labels.
- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 


saveData(clean_data, filename) - This is a function to save data into a file. The source data variable and the file location needs to be provided.

cleanData(merged_data) - This is  function to create a tidy data from test and training data set. The data that needs to be cleaned has to be be passed. 

This generates two files - 

- tidy_data.txt - clean data set 
- aggregate_UCI_mean_tidy_data.txt - average mean value grouped by subjectID and activity.

run_analysis()- This is the main function that calls extractData(), loadFiles() and cleanData().

