repo_list<-content(req)
answer1 <- c() 
for (i in 1:length(repo_list)) {
	repo <- repo_list[[i]]
	if (repo$name == "datasharing") {
		answer1 <- repo
		break
	}
}

answer1$created_at
[1] "2013-11-07T13:25:07Z"


#Que-2
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
f <- file.path(getwd(), "getdata%2Fdata%2Fss06pid.csv")
download.file(url, f, mode = "wb")
acs<-read.csv(f)

#Que-4
tryCatch({
	con <- url("http://biostat.jhsph.edu/~jleek/contact.html")
	html <- readLines(con)
}, finally = {
	close(con)
})

x<-c(html[10],html[20],html[30],html[100])
 nchar(x)
 [1] 45 31  7 25
 
 # Que -5
 url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for"
 lines <- readLines(url, n = 10)
 w <- c(1, 9, 5, 4, 1, 3, 5, 4, 1, 3, 5, 4, 1, 3, 5, 4, 1, 3)
 colNames <- c("filler", "week", "filler", "sstNino12", "filler", "sstaNino12", 
 							"filler", "sstNino3", "filler", "sstaNino3", "filler", "sstNino34", "filler", 
 							"sstaNino34", "filler", "sstNino4", "filler", "sstaNino4")
 d <- read.fwf(url, w, header = FALSE, skip = 4, col.names = colNames)
 d <- d[, grep("^[^filler]", names(d))]
 sum(d[, 4])
 ## [1] 32427
 