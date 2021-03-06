# Download and save the original dataset
energyFile <- paste(getwd(), .Platform$file.sep, "household_power_consumption.txt", sep = '')

dataURL <- "http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if(!file.exists(energyFile)) {
  temp <- tempfile()
  download.file(dataURL, temp)
  energyFile <- unzip(temp)
  unlink(temp)
}
#read the file
energyConsumption <- read.table(energyFile, header=T, sep=";")
# Select data from 1/2/2007 to 2/2/2007
febData <- energyConsumption[energyConsumption$Date %in% c("1/2/2007","2/2/2007") ,]
rm(energyConsumption)

## Converting dates
datetime <- strptime(paste(febData$Date, febData$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 
globalActivePower <- as.numeric(febData$Global_active_power)

## Plot 2
plot(datetime, globalActivePower,  type="l",
     ylab="Global Active Power (kilowatts)", xlab="")
dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()