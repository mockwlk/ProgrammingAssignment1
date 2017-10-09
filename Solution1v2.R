#install.packages("data.table")
library(data.table)
library(microbenchmark)

#install.packages("microbenchmark")
#install.packages("data.table")
#clear memory
rm(list=ls())

#set path to get files
pathData = "C:/Users/mockwlk/Desktop/R Programming/Assg1/specdata"
#print(path)

#define function to get average
polluteMean <- function(pathInput,pollutant,id)
{
  
  #get all files in directory
  files <- list.files(pathInput, pattern="*.csv", full.names=T, recursive=FALSE)         
  
  #bind all the files 
  DT = rbindlist(lapply(files, fread))
  #print(DT)
  #set date format
  #DT$Date<-as.Date(as.character(DT$Date,"%Y-%m-%d"))
  
  #remove entries which have at least a null inside
  DT<-DT[complete.cases(DT)]
  
  #filter data set to only those relevant ids and get mean
  DTFilter<-DT[DT$ID %in% id]
  resultMean<-mean(DTFilter[[pollutant]])
  resultMean
}

Result = polluteMean(pathData,"sulfate",1:10)
print(Result)
Result = polluteMean(pathData,"nitrate",70:72)
print(Result)
Result = polluteMean(pathData,"nitrate",23)
print(Result)



# Start the clock!
ptm <- proc.time()
polluteMean(pathData,"nitrate",70:72)
# Start the clock!
proc.time() - ptm

