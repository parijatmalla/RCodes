pollutantmean<-function (directory, pollutant,id=1:332){
  ##setwd(/media/sf_DataScience/Course2/week2/assignment/rprog_data_specdata/specdata/)
 ## setwd(directory)
  
  #initialize mean_vector
  mean_vector <- c()
  
  #start the loop for monitor IDs provided
 for (i in id){
   #Generate fix  width CSV file name
  charid<-paste(formatC(i,width=3,flag="0"),".CSV",sep="")
    
 #read the data from the provided monitorIDs and store in the variable
  currentfiles<-read.csv(charid)     
  
  #remove na
  na_removed<-currentfiles[!is.na(currentfiles[,pollutant]),pollutant] 
mean_vector <- c(mean_vector, na_removed)
 }
  result<-mean(mean_vector)
  return(result)
 ##   x<-paste(length(id))
 ##     
 
 
}