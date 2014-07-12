## Getting the requisite library which reads the data faster.
library(data.table)
## This is assuming the file is in the the working directory.
myFile <- "household_power_consumption.txt"
## Load the data.
data <- fread(myFile, na.string = "?")
## Use data.table and make a dataframe.
datatable <- data.table(data)
## Remove the original data object.
rm(data)
## Extract the relevant data.
subtable <- subset(datatable,Date=="1/2/2007" | Date=="2/2/2007")
## Remove the original data frame. Note: we can also store this into the original, but for the sake of clarity
## I havent done so
rm(datatable)
##
## Prepare the data for the plot(s).
datetime <- strptime(paste(subtable$Date,subtable$Time), format = "%d/%m/%Y %H:%M:%S")
power <- as.numeric(subtable$Global_active_power)
voltage <- as.numeric(subtable$Voltage)
sub1 <- as.numeric(subtable$Sub_metering_1)
sub2 <- as.numeric(subtable$Sub_metering_2)
sub3 <- as.numeric(subtable$Sub_metering_3)
reactive <- as.numeric(subtable$Global_reactive_power)
## Start the plot png.
png(file="4.png",width = 504, height = 504)
## Make the division to accomodate 4 plots row-wise
par(mfrow = c(2,2))
## Plot the top left graph
plot(datetime,power,type='l',ylab="Global Active Power",col="black",xlab="")
## Plot the top right graph
plot(datetime,voltage,type='l',ylab = "Voltage",xlab = "datetime",col="black")
## Plot the bottom left graph and add its required additional lines
plot(datetime,sub1,type='l',col="black", ylab = "Energy sub metering", xlab = "", main="")
lines(datetime,sub2,type='l',col="red")
lines(datetime,sub3,type='l',col="blue")
legend("topright",lty=1,legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"),bty="n")
## Plot the bottom right graph
plot(datetime,reactive,xlab="datetime",ylab="Global_reactive_power",type="l")
## Close the graphic device
dev.off()