# Question 1
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
f <- file.path(getwd(), "getdata%2Fdata%2Fss06hid.csv")
download.file(url, f, mode = "wb")
acs<-read.csv(f)

agricultureLogical<-(acs$ACR==3 & acs$AGS==6)
	which(agricultureLogical)
print

#Question 2
install.packages("jpeg")
library('jpeg')
url<-"https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"
f <- file.path(getwd(), "getdata%2Fjeff.jpg")
download.file(url, f, mode = "wb")

img<-readJPEG(f,native=TRUE)
quantile(img,probs=c(0.3,0.8))

#question 3
url<-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
f <- file.path(getwd(), "getdata%2Fdata%2FGDP.csv")
download.file(url, f, mode = "wb")

colnames<-c("CountryCode","Ranking","Economy","Dollars")
gdp<-read.csv(f,header=FALSE,nrows=190, skip=5)
gdp_selected<-select(gdp,"V1","V2","V4","V5")
#setNames(gdp_selected,c("V1","V2","V5","V5")[names(gdp_selected) %chin% c("V1","V2","V5","V5")],c("CountryCode","Ranking","Economy","Dollars")[names(gdp_selected) %chin% c("X","X.1","X.3","X.4")])
url<-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
f <- file.path(getwd(), "getdata%2Fdata%2FEDSTATS_Country.csv")
download.file(url, f, mode = "wb")
edu<-read.csv(f)


x<-merge(gdp_selected,edu,by.x="V1",by.y="CountryCode")
#x<-merge(edu,gdp_selected,by.x="CountryCode",by.y="X",)
	arrange(x,desc(V2))

	
	#Question 4
	aggregate(x[,2],list(x$Income.Group),mean)
	
	#question 5
	# Create a data table with a minimum number columns to preserve memory
	DT <- subset(x, select = c(Income.Group, V2)) %>%
		mutate(quantileGDP = cut2(x$V2, g =  5)) %>%
		data.table
	
	# Select the number of countries falling into the required category (quantile)
	answer5 <- DT[Income.Group == "Lower middle income", .N, 
								by = c("Income.Group", "quantileGDP")] %>%
		subset(quantileGDP == "[  1, 39)", select = N)
	
	# Expected output: "There are 5 countries with Lower middle income but among the 38 nations with highest GDP"
	msg("There are", answer5, "countries with Lower middle income but among the 38 nations with highest GDP")
	
	

	
