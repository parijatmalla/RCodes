pollutantmean<-function (directory, pollutant,id=1:332){
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'pollutant' is a character vector of length 1 indicating
  ## the name of the pollutant for which we will calculate the
  ## mean; either 'sulfate' or 'nitrate'
  
  ## 'id' is an integer vector indicating the monitor ID numbers
  ## to be used
  
  ## Return the mean of the pollutant across all monitors list
  ## in the 'id' vector (ignoring NA values)
  ## NOTE: Do not round the result!


  #initialize mean_vector
  mean_vector <- c()
  
  #start the loop for monitor IDs provided
 for (i in id){
   #Generate fix  width CSV file name
   
  
  charid<-paste(formatC(i,width=3,flag="0"),".csv",sep="")
    
 #read the data from the provided monitorIDs and store in the variable
  charid<-paste(directory,charid,sep="") 
 
  currentfiles<-read.csv(charid)     
 
  
  #remove na
  na_removed<-currentfiles[!is.na(currentfiles[,pollutant]),pollutant]
 
 mean_vector <- c(mean_vector, na_removed)
 
 }
  result<-mean(mean_vector)
  return(result)
 
      
 
 
}