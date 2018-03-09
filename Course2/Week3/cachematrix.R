## Put comments here that give an overall description of what your
## functions do

## Write a short comment describing this function


## makeCacheMatrix function creates a list containing a function to
# get the value of a matrix
# set the value of the matrix
# get inverse value of a matrix
# set inverse value of a matrix

makeCacheMatrix <- function(x = matrix()) {

    
inverse<-NULL
set<-function(y){
  x<<-y
  inverse<<-NULL
}

# function to get the value of a matrix
get<-function (){
  x
}
  
# function to get the inverse value  of a matrix
getinverse<-function (){
  inverse
}

# function to set the inverse value of a matrix
setinverse<-function(y){
  inverse<-y}

list(set=set,get=get,setinverse=setinverse,getinverse=getinverse)
}


## Write a short comment describing this function 


## cacheSolve function return the inverse of a matrix
## if the inverse has already been computed, the same is returned and does not recompute the inverse value
## If the inverse value has not been computed already, it computes the inverse value of a matrix

cacheSolve <- function(x, ...) {
 
## Return a matrix that is the inverse of 'x'

  
  # check if inverse value has already been computed before  
  inverse<-x$getinverse()
  if (!is.null(inverse)){
    message ("Processing...")
    return (inverse)
  }
  
  
  inputm<-x$get()
 
  #computes the inverse of a matrix
  inverse<-solve(inputm)
  
  x$setinverse(inverse)
  inverse
  
  
}
