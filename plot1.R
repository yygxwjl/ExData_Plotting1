# This file will create plot1.png

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
png("plot1.png", height=480, width=480)

hist(data$Global_active_power, col='red', 
     xlab = 'Global Active Power (kilowatts)',
     main = 'Global Active Power')

dev.off()