#install.packages("data.table")
#install.packages("plyr")
library(data.table)
library(microbenchmark)
library(plyr)

#clear memory
rm(list=ls())

#set path to get files
pathData = "C:/Users/mockwlk/Desktop/R Programming/Assg1/specdata"

polluteStat <- function(pathData,threshold)
{
  
#get all files in directory
files <- list.files(pathData, pattern="*.csv", full.names=F, recursive=FALSE)         

#bind the files with filename
DT = setDT(rbindlist(lapply(files, fread)))
print(DT)

#remove entries which have at least a null inside
DT<-DT[complete.cases(DT)]
print(DT)

#get sum of all the IDs
DTFilter<-DT

#count the IDs and put into a dataset
DTFilter<-setDT(count(DTFilter, c('ID')))
print(DTFilter)

#Below assignment creates a copy
DTFilter<-setDT(DTFilter[freq >threshold])
print(DTFilter)

#filter required inputs 
DT<-DT[DT$ID %in% DTFilter[,ID]]
print(DT)

#aggregate output
correlationVector<-ddply(DT,"ID",function(x) cor(x$sulfate,x$nitrate))
#print(correlationVector)
correlationVector

}

# Start the clock!
ptm <- proc.time()
correlationVector<-polluteStat(pathData,150)
head(correlationVector)
summary(correlationVector)
# Start the clock!
proc.time() - ptm

  
