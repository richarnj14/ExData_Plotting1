## plot1.R

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
power_sub$Date <- as.Date(power_sub$Date, format="%d/%m/%Y")

## Open PNG graphics device and construct histogram of Global_active_power
png(filename="plot1.png", width = 480, height = 480)
hist(as.numeric(power_sub$Global_active_power), col="red", xlab="Global Active Power (Kilowatts)", main="Global Active Power")
dev.off()
cat("plot1.png has been saved in", getwd())

