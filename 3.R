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
## Prepare the data for the plot.
datetime <- strptime(paste(subtable$Date,subtable$Time), format = "%d/%m/%Y %H:%M:%S")
sub1 <- as.numeric(subtable$Sub_metering_1)
sub2 <- as.numeric(subtable$Sub_metering_2)
sub3 <- as.numeric(subtable$Sub_metering_3)
## Start the plot png.
png(file="3.png")
## Make the initial plot with one the black i.e. sub metering 1
plot(datetime,sub1,type='l',col="black", ylab = "Energy sub metering", xlab = "", main="")
## Add to it the second and the third sub metering columns
lines(datetime,sub2,type='l',col="red")
lines(datetime,sub3,type='l',col="blue")
## Make the legend
legend("topright",lty=1,legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"))
## Remove the data required for graph from global environment.
rm(sub1)
rm(sub2)
rm(sub3)
rm(datetime)
## Close the graphic device
dev.off()