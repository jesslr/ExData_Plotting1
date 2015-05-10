library(data.table)

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

## Create plot 1, red histogram showing frequency of Global Active Power observations
hist(subData$Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")

## Save plot in file with 480x480 pixel size
dev.print(png, file = "plot1.png", width = 480, height = 480)
png(file = "plot1.png", bg = "transparent")
dev.off()

