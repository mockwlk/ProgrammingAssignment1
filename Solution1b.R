#install.packages("data.table")
#install.packages("plyr")
library(data.table)
library(microbenchmark)
library(plyr)

#clear memory
rm(list=ls())

#set path to get files
pathData = "C:/Users/mockwlk/Desktop/R Programming/Assg1/specdata"
#print(path)

#define function to get average
polluteCount <- function(pathInput,id)
{
 
  #get all files in directory
  files <- list.files(pathInput, pattern="*.csv", full.names=F, recursive=FALSE)         
  
  #bind the files with filename
  DT = rbindlist(Map(`cbind`,lapply(files, fread),files))
  
  #print colnames and dimensions
  colnames(DT)
  dim(DT)
  
  #rename to filename
  colnames(DT)[5] <- 'Filename'
  colnames(DT)
  
  #remove entries which have at least a null inside
  DT<-DT[complete.cases(DT)]
  print(DT)
  
  DTFilter<-DT[DT$ID %in% id]
  resultCount<-count(DTFilter, c('ID', 'Filename'))
  #print(resultCount)
  print(resultCount[, c(1,3,2)])
  
}

# Start the clock!
ptm <- proc.time()
polluteCount(pathData,1)
# Start the clock!
proc.time() - ptm


# Start the clock!
ptm <- proc.time()
polluteCount(pathData,30:25)
# Start the clock!
proc.time() - ptm


# Start the clock!
ptm <- proc.time()
polluteCount(pathData,c(2, 4, 8, 10, 12))
# Start the clock!
proc.time() - ptm


