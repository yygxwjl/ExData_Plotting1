# This file will create plot3.png

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
png("plot3.png", height=480, width=480)

plot(data$DateTime, 
     data$Sub_metering_1, 
     pch=NA, 
     xlab="", 
     ylab="Energy sub metering")
lines(data$DateTime, data$Sub_metering_1)
lines(data$DateTime, data$Sub_metering_2, col='red')
lines(data$DateTime, data$Sub_metering_3, col='blue')
legend('topright', 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty = c(1,1,1),
       col = c('black', 'red', 'blue'))

dev.off()