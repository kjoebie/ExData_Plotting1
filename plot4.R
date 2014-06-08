root <- "C:/Users/albert.QBIDS/Coursera/Johns Hopkins/The Data Science Track/4 Exploratory Data Analysis/Project"
setwd(root)

datafile <- paste(root,"/household_power_consumption.txt", sep="")
colclasses <- c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric")
headers <- c("Date", "Time", "Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")

#read data from 2007-02-01 and 2007-02-02
#first line starts at rownumber 66637 (incl header) so skip the first 66636 lines
#the first line of 2007-02-03 starts at rownumber 69517, so the last line of 2007-02-02 is at rownumber 69516
#therefore we can read 69516 - 66636 = 2880 lines to get the whole set we need
data <- read.table(datafile, sep=";",colClasses = colclasses, col.names =headers, comment.char="", na.strings="?", header=F, skip=66636, nrow=2880)

#convert the columns to the appropriate datatypes

data$DateTime <- strptime(paste(data$Date, data$Time), format = "%d/%m/%Y %H:%M:%S")
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
data$Time <-  strptime(data$Time, format = "%H:%M:%S")
#View(data)


#set global parameters for the graphs
#set mfrow to get two rows and two colums
par(mfrow = c(2,2))
#set the fontsize of label and axis a bit smaller
par(cex.lab=0.85, cex.axis=0.85)

#first plot, upper left
plot(data$DateTime,data$Global_active_power, type="l", xlab="", ylab="Global Active Power")

#second plot, upper right
plot(data$DateTime,data$Voltage, type="l", xlab="datetime", ylab="Voltage")

#third plot, lower left
plot(data$DateTime,data$Sub_metering_1, type="n", xlab="", ylab="Energy sub metering")
lines(data$DateTime,data$Sub_metering_1, type="l", col="black")
lines(data$DateTime,data$Sub_metering_2, type="l", col="red")
lines(data$DateTime,data$Sub_metering_3, type="l", col="blue")
#make the legendbox a bit smaller: cex=0.75
#and no line around the legend (boxtype): bty="n"
legend("topright", lty=c(1,1), col=c("black", "blue", "red"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), cex=0.75,bty="n")

#fourth plot, lower right
plot(data$DateTime,data$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")

#create a .png file
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()
