## plot4.R

## Download data - if necessary
filename <- "household_power_consumption.zip"
if (!file.exists(filename)){
     fileURL <- "http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
     download.file(fileURL, filename)
}  
if (!file.exists("household_power_consumption.txt")) { 
     unzip(filename) 
}

## Read data
power <- read.table("household_power_consumption.txt", header=TRUE, sep=";", colClasses="character")

## Subset for Feb 1-2, 2007
power_sub <- subset(power, power$Date == "1/2/2007" | power$Date == "2/2/2007")

## Replace missing values with NA
power_sub[power_sub=="?"] <- NA

## Convert date and time fields
power_sub <- transform(power_sub, timestamp=as.POSIXct(paste(power_sub$Date, power_sub$Time), format="%d/%m/%Y %H:%M:%S"))
power_sub$Date <- as.Date(power_sub$Date, format="%d/%m/%Y")

## Open PNG graphics device and construct plots
png(filename="plot4.png", width = 480, height = 480)
par(mfrow=c(2,2))

plot(power_sub$timestamp, power_sub$Global_active_power, type="l", xlab="", ylab="Global Active Power")

plot(power_sub$timestamp, power_sub$Voltage, type="l", xlab="datetime", ylab="Voltage")

plot(power_sub$timestamp, power_sub$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(power_sub$timestamp, power_sub$Sub_metering_2, col="red")
lines(power_sub$timestamp, power_sub$Sub_metering_3, col="blue")
legend("topright", col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty=c(1,1,1), bty="n")

plot(power_sub$timestamp, power_sub$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")

dev.off()
cat("plot4.png has been saved in", getwd())