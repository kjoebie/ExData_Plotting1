root <- "C:/Users/albert.QBIDS/Coursera/Johns Hopkins/The Data Science Track/4 Exploratory Data Analysis/Project"
setwd(root)

#make sure we have only 1 graph on the screen
par(mfrow=c(1,1)) 

datafile <- paste(root,"/household_power_consumption.txt", sep="")
colclasses <- c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric")
headers <- c("Date", "Time", "Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")

#read data from 2007-02-01 and 2007-02-02
#Note: after examining the data first I concluded that the data is ordered. 
#Therefore I choose to use the technique to skip lines instead of subsetting them.

#first line starts at rownumber 66637 (incl header) so skip the first 66636 lines
#the first line of 2007-02-03 starts at rownumber 69517, so the last line of 2007-02-02 is at rownumber 69516
#therefore we can read 69516 - 66636 = 2880 lines to get the whole set we need
data <- read.table(datafile, sep=";",colClasses = colclasses, col.names =headers, comment.char="", na.strings="?", header=T, skip=66636, nrow=2880)

#convert the columns to the appropriate datatypes
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
data$Time <-  strptime(data$Time, format = "%H:%M:%S")

#create the historgram
hist(data$Global_active_power, col="red",xlab="Global Active Power (kilowatts)", main="Global Active Power")


#create a .png file
# store as image of certain size: 480 x 480
png(filename=".\\Github\\plot1.png")
hist(data$Global_active_power, col="red",xlab="Global Active Power (kilowatts)", main="Global Active Power")
dev.off()
