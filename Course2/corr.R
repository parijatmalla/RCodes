corr<- function (directory, threshold=0){
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'threshold' is a numeric vector of length 1 indicating the
  ## number of completely observed observations (on all
  ## variables ) required to compute the correlation between
  ## nitrate and sulfate; the default is 0
   
  ## Return a numeric vector of correlations
  ## NOTE : Do not round the result

  ##setwd(substr(directory, 1, nchar(directory)-nchar(directory)))
  
  completecases <- c()
  corr_result<-c()
    ##corr_result<<-data.frame()
  counter<-1
  
  #start the loop for monitor IDs provided
  for (i in 1:332){
    #Generate fix  width CSV file name
    fname<-paste(formatC(i,width=3,flag="0"),".csv",sep="")
    fname<-paste(directory,fname,sep="") 
    
    #read the data from the provided monitorIDs and store in the variable
    ##currentfiles<-read.csv(file.path(directory,fname) )    
    currentfiles<-read.csv(fname) 
    
    #find no. of complete observations
    
    completecases <- sum(complete.cases(currentfiles))
    
    if (sum(complete.cases(currentfiles))>threshold){
    # corr_result<-rbind(corr_result,currentfiles)
    #  corr_result[i]<-cor (corr_result$nitrate , corr_result$sulfate,use="complete.obs")
     corr_result[counter]<-cor (currentfiles$nitrate , currentfiles$sulfate,use="complete.obs")
     counter<-counter+1 
    }
    
  }
  return (corr_result)
}
