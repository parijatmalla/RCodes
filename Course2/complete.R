complete<-function (directory, id=1:332)
{
  
  ## 'directory' is a character vector  of length 1 indicating
  ## the location of the CSV files
  
  ## 'id' is an integer vector indicating the monitor ID numbers
  ## to be used
  
  ## Return a data frame of the form:
  ## id nobs
  ## 1 117
  ## 2 1041
  ## ...
  ## where 'id' is the monitor ID number and 'nobs' is the
  ## number of complete cases
  
  
  #initialize mean_vector
  completecases <- c()
  nob_result<-data.frame()
  
  #start the loop for monitor IDs provided
  for (i in id){
    #Generate fix  width CSV file name
    charid<-paste(formatC(i,width=3,flag="0"),".CSV",sep="")
    
    #read the data from the provided monitorIDs and store in the variable
    currentfiles<-read.csv(charid)     
    
    #find no. of complete observations
 
    completecases <- sum(complete.cases(currentfiles))
    nob_result<- rbind(nob_result,data.frame(id=i,nobs=completecases))
  }
  return (nob_result)
}