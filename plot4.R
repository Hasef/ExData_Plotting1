##
## Solution plot4:
##
## Data File household_power_consumption.txt is assumed to be located
## in current working directory of your R workspace.
##
## HOW TO: > source("plo4.R")
##
## ==> The file "plot4.png" will be created in your current working directory!
##

##
## General part for ALL 4 plotting requirements:
##

# create a clean workspace:
rm(list=ls())

library(dplyr)
library(lubridate)

# load data:
ds <- read.table(file="household_power_consumption.txt", header=TRUE, sep=";")

# from "Data" variable create a real data-type variable ds
# that will be used in next step to subset the data to the 2 required days:
ds1 <- mutate(ds, Dt=as.Date(Date,format="%d/%m/%Y"))

# subset data for only the 2 required days:
ds2 <- filter(ds1, Dt>="2007-02-01", Dt<="2007-02-02")

# Create number-data type variables for the variables of interest w.r.t. 
# all four plotting requirements:
ds3 <- mutate(ds2
              , Ngap=as.numeric(as.character(Global_active_power))
              , Nsm1=as.numeric(as.character(Sub_metering_1))
              , Nsm2=as.numeric(as.character(Sub_metering_2))
              , Nsm3=as.numeric(as.character(Sub_metering_3))
              , Nvol=as.numeric(as.character(Voltage))
              , Ngrp=as.numeric(as.character(Global_reactive_power)))

# Create a character-type variable "dtstring" that concatenates the
# Date-string and Time-string of given variables "Date" and "Time":
ds4 <- mutate(ds3, dtstring= paste(Date,Time))

##
## Individual part w.r.t plot 4: Create the plot into the file plot4.png:
##
png(filename="plot4.png", width=480, height=480)
Sys.setlocale("LC_TIME", "English")

##par(mfrow=c(2,2))

par(mfrow = c(2, 2), mar = c(4, 4, 2, 1)) ##, oma = c(0, 0, 2, 0))


##upper left plot:
with(ds4, plot(strptime(dtstring, "%d/%m/%Y %H:%M:%S"), 
               Ngap, 
               type="l", ylab="Global Active Power", xlab=""))

##upper right plot:
with(ds4, plot(strptime(dtstring, "%d/%m/%Y %H:%M:%S"), 
               Nvol, 
               type="l", ylab="Voltage", xlab="datetime"))

##lower left plot:
with(ds4, plot(strptime(dtstring, "%d/%m/%Y %H:%M:%S"), 
               Nsm1, 
               col="black", type="l", 
               xlab="", ylab="Energy sub metering"))
with(ds4, points(strptime(dtstring, "%d/%m/%Y %H:%M:%S"), 
                 Nsm2, 
                 col="red", type="l"))
with(ds4, points(strptime(dtstring, "%d/%m/%Y %H:%M:%S"), 
                 Nsm3, 
                 col="blue", type="l"))
legend("topright", col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty="21")

##lower right plot:
with(ds4, plot(strptime(dtstring, "%d/%m/%Y %H:%M:%S"), 
               Ngrp, 
               col="black", type="l", 
               xlab="datetime", ylab="Global_reactive_power"))
dev.off()

