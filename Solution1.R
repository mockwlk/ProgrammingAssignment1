#install.packages("data.table")
library(data.table)

#clear memory
rm(list=ls())

setwd("C:/Users/mockwlk/Desktop/R Programming/Assg1/specdata")
getwd()
path = "C:/Users/mockwlk/Desktop/R Programming/Assg1/specdata"
print(path)

#define variables
total<-0
observations <-0
            
#get all files in directory
files <- list.files(path, pattern="*.csv", full.names=T, recursive=FALSE)           
print(files)

#bind all the files 
DT = rbindlist(lapply(files, fread))
print(DT)
DT$Date<-as.Date(as.character(DT$Date,"%Y-%m-%d"))

#remove entries which have at least a null inside
DT<-DT[complete.cases(DT)]
DTFilter<-DT[DT$ID %in% 70:72]
DTFilter
mean(DTFilter$nitrate)

#define function to get average
polluteMean <- function(x, pollutant, id)
{
    print(x)
    print(pollutant)
    print(id)
    DTFilter<-x[x$ID %in% id]
    print(DTFilter)
    #mean(DTFilter$pollutant)
    resultMean<-mean(DTFilter[[pollutant]])
    
    #
    #if(pollutant=="nitrate")
    #  resultMean <-mean(DTFilter$nitrate)
    #else
    #  resultMean <-mean(DTFilter$sulphate)
    resultMean
}

Result = polluteMean(DT,"nitrate",70:72)
print(Result)
