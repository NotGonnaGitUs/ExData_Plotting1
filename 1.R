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
Power <- as.numeric(subtable$Global_active_power)
## Start the plot png.
png(file="1.png")
## Plotting the histogram
hist(Power,col="red",main = "Global Active Power",xlab = "Global Active Power (kilowatts)")
## Close the graphic device
dev.off()