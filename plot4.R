# This file will create plot4.png

# function for reading data from file, subsit it, and convert date and time to format.
read_data <- function() {
  
  # read from file
  data <- read.table("./household_power_consumption.txt",
                     sep=";", header=TRUE,
                     colClasses=c('character', 'character',
                                  'numeric', 'numeric',
                                  'numeric', 'numeric',
                                  'numeric', 'numeric',
                                  'numeric'),
                     na.strings='?')
  
  #subset
  data <- data[data$Date=="1/2/2007" | data$Date=="2/2/2007", ]
  
  # format
  data$DateTime <- strptime(paste(data$Date, data$Time), 
                            "%d/%m/%Y %H:%M:%S")
  return(data)
}


data <- read_data()

# create the png
png("plot4.png", height=480, width=480)

# 4 parts
par(mfrow=c(2,2))

plot(data$DateTime, 
     data$Global_active_power, 
     pch=NA, 
     xlab="", 
     ylab="Global Active Power")
lines(data$DateTime, data$Global_active_power)

plot(data$DateTime, data$Voltage, ylab="Voltage", xlab="datetime", pch=NA)
lines(data$DateTime, data$Voltage)

# Submetering plot
plot(data$DateTime, 
     data$Sub_metering_1, 
     pch=NA, 
     xlab="", 
     ylab="Energy sub metering")

# put lines
lines(data$DateTime, data$Sub_metering_1)
lines(data$DateTime, data$Sub_metering_2, col='red')
lines(data$DateTime, data$Sub_metering_3, col='blue')

# put legend
legend('topright', 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty = c(1,1,1),
       col = c('black', 'red', 'blue'),
       bty = 'n')
with(data, plot(DateTime, Global_reactive_power, xlab='datetime', pch=NA))
with(data, lines(DateTime, Global_reactive_power))

dev.off()