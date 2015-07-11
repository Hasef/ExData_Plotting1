##
## Solution plot2:
##
## Data File household_power_consumption.txt is assumed to be located
## in current working directory of your R workspace.
##
## HOW TO: > source("plot2.R")
##
## ==> The file plot2.png will be created in your current working directory!
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
## Individual part w.r.t plot 2: Create the plot into the file plot2.png:
##
png(filename="plot2.png", width=480, height=480)

Sys.setlocale("LC_TIME", "English")
with(ds4, plot(strptime(dtstring, "%d/%m/%Y %H:%M:%S"), Ngap, type="l", ylab="Global Active Power(kilowatts)", xlab=""))

dev.off()


