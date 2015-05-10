library(data.table)

#setwd("~/Coursera/ExploratoryAnalysis")

## Read in data and convert ? to NA
data <- fread("./household_power_consumption.txt", na.strings=c("?","NA"))

## Convert date to a date format
data$Date <- as.Date(data$Date, "%d/%m/%Y")

## Get data for dates we are interested in exploring
subData <- data[data$Date=="2007-02-01" | data$Date=="2007-02-02"]

## No need to keep original data in environment
rm(data)

## Create field for date/time 
subData$DateTime <- paste(subData$Date, subData$Time)
subData$DateTime <- as.POSIXct(paste(subData$Date, subData$Time), format="%Y-%m-%d %H:%M:%S")

## Change order of columns
setcolorder(subData, c(1,2,10,3,4,5,6,7,8,9))

## Convert to numeric
subData$Global_active_power <- as.numeric(subData$Global_active_power)
subData$Sub_metering_1 <- as.numeric(subData$Sub_metering_1)
subData$Sub_metering_2 <- as.numeric(subData$Sub_metering_2)
subData$Voltage <- as.numeric(subData$Voltage)
subData$Global_reactive_power <- as.numeric(subData$Global_reactive_power)

## Save plot in file with 480x480 pixel size
png(file="plot4.png", width=480, height=480)

## Set up to display plots 2 x 2
par(mfrow=c(2,2))

## Create plot 4, 4 different plots (2x2) by DateTime
# Global active power, Voltage, Energy sub metering, global reactive power are plotted by DateTime
with(subData, {
    plot(Global_active_power ~ DateTime, type="l", xlab="", ylab="Global Active Power (kilowatts)")
    plot(Voltage ~ DateTime, type="l", xlab="datetime")
    plot(Sub_metering_1 ~ DateTime, type="n", xlab="", ylab="Energy sub metering")
    lines(subData$Sub_metering_1 ~ subData$DateTime)
    lines(subData$Sub_metering_2 ~ subData$DateTime, col="red")
    lines(subData$Sub_metering_3 ~ subData$DateTime, col="blue")
    # add the legend at the top right corner
    legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=c(1,1,1),
           lwd=c(2,2,2),col=c("black","red","blue"), bty="n", cex=.85)
    plot(Global_reactive_power ~ DateTime, type="l", xlab="datetime")
}
)

dev.off()



