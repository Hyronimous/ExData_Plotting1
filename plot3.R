file.name <- "./household_power_consumption.txt"
url       <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
zip.file  <- "./household_power_consumption.zip"


# Check if the data is downloaded and download when applicable
if (!file.exists("./household_power_consumption.txt")) {
  download.file(url, destfile = zip.file)
  unzip(zip.file)
}

# Reading the file
# clean up the ? values while reading and convert to NA
hhcons <- read.csv(file.name,sep=";",dec = ".",na.strings = c("?"))
hhcons <- subset(hhcons, Date=="1/2/2007"| Date =="2/2/2007")


# converting date and time
library(lubridate)
hhcons$Date <- dmy(hhcons$Date)
hhcons$Time <- hms(hhcons$Time)
hhcons$newdate <- hhcons$Date + hhcons$Time


png("plot3.png" , width=480, height=480)

with(hhcons,
     {
       plot(hhcons$newdate, hhcons$Sub_metering_1, type = "n" , ylab="Energy sub metering", xlab = "") 
       lines(hhcons$newdate, hhcons$Sub_metering_1, type="l")
       lines(hhcons$newdate, hhcons$Sub_metering_2, type="l", col="red")
       lines(hhcons$newdate, hhcons$Sub_metering_3, type="l", col="blue")
       
       legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c("black","red","blue"), 
              lwd=2);
       
       
     }
     )
dev.off()