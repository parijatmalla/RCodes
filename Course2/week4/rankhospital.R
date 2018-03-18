rankhospital<-function (state,outcome, num="best"){
	
	## the function takes in 3 arguments state, outcome and rank 
	## and returns the hospital with the lowest 30 day death rate heart failure 
	# with the rank supplied
	
	## Read outcome data
	data <- read.csv("outcome-of-care-measures.csv", colClasses = "character",na.strings="Not Available")
	## Check that state and outcome are valid
	validOutcome = c("heart attack","heart failure","pneumonia")
	if (!outcome %in% validOutcome) { stop("Invalid Outcome!")}
	
	validState = unique(data[,7])
	if (!state %in% validState) stop("Invalid State")
	
	## convert outcome name into column name
	fullColName <- c("Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack", "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure", "Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia")
	colName <- fullColName[match(outcome,validOutcome)]
	
	## Return hospital name in that state with the given rank 30-day death rate
	data.state <- data[data$State==state,]
	
	# order data by outcome
	sorted.data.state <- data.state[order(as.numeric(data.state[[colName]]),data.state[["Hospital.Name"]],decreasing=FALSE,na.last=NA), ]
	
	#handle num input
	if (num=="best") num = 1
	if (num=='worst') num = nrow(sorted.data.state)
	#will automatically return NA if num > nrow, as well as if it's some other text value
	# if someone passes num < 1, they'll get what's expected
	#if (is.numeric(num) & num > nrwo(sorted.data.state) return(NA)
	
	sorted.data.state[num,"Hospital.Name"]	
	
}