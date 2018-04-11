url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf"
f <- file.path(getwd(), "PUMSDataDict06.pdf")
download.file(url, f, mode = "wb")

## filtering based on column value
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
f <- file.path(getwd(), "getdata%2Fdata%2Fss06hid.csv")
download.file(url, f, mode = "wb")
fd<-read.csv(f)
result<-fd[which(fd$VAL =="24"),]
dt<-data.table(fd)
setkey(dt,FES)
dt[,.N,key(dt)]

## read xlsx
row<-18:23
col<-7:15
file<-read.xlsx('/media/sf_DataScience/Course 3/week1/gov_NGAP.xlsx',sheetIndex = 1,colIndex=col, rowIndex=row)
dat<-file
sum(dat$Zip*dat$Ext,na.rm=T)

## [1] 36534720


## read xml
xmlfile<-xmlParse("/media/sf_DataScience/Course 3/week1/restaurants.xml")
xml_data <- xmlToList(xmlfile)

length(unlist(lapply(xml_data$row, function(row) row$name[row$zipcode==21231]), use.names = FALSE))


# fread
#install package data.table
DT<-fread('/media/sf_DataScience/Course 3/week1/getdatapid.csv',sep=",",header=TRUE)

starttime<-Sys.time()
mean(tapply(DT$pwgtp15,DT$SEX,mean))
endtime<-Sys.time()
endtime-starttime



Time difference of 0.003656387  secs

starttime<-Sys.time()
mean(DT$pwgtp15,by=DT$SEX)
endtime<-Sys.time()
endtime-starttime
Time difference of 0.001052618 secs


starttime<-Sys.time()
rowMeans(DT)[DT$SEX==1]; rowMeans(DT)[DT$SEX==2]
endtime<-Sys.time()
endtime-starttime
Time difference of 1.045556 secs

x <- {mean(DT[DT$SEX==1,]$pwgtp15), mean(DT[DT$SEX==2,]$pwgtp15)}
microbenchmark::microbenchmark(DT[,mean(pwgtp15),by=SEX], 
															 mean(DT[DT$SEX==1,]$pwgtp15),
															 tapply(DT$pwgtp15,DT$SEX,mean),
															 sapply(split(DT$pwgtp15,DT$SEX),mean),
												
															 mean(DT[DT$SEX==1,]$pwgtp15), mean(DT[DT$SEX==2,]$pwgtp15),
															 
															 times = 10000)


starttime<-Sys.time()
DT[,mean(pwgtp15),by=SEX]
endtime<-Sys.time()
endtime-starttime
Time difference of 0.003046751 secs

starttime<-Sys.time()
mean(DT[DT$SEX==1,]$pwgtp15); mean(DT[DT$SEX==2,]$pwgtp15)
endtime<-Sys.time()
endtime-starttime
Time difference of 0.04288554 secs

starttime<-Sys.time()
sapply(split(DT$pwgtp15,DT$SEX),mean)
endtime<-Sys.time()
endtime-starttime
Time difference of 0.002850056 secs
