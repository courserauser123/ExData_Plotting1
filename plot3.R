### STEP 1: load the data

# open file, prepare data$Date as Date type.
data <- read.table("household_power_consumption.txt", sep = ";", stringsAsFactors = FALSE, header = TRUE)
timestamp <- strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S")
data$Date <- as.Date(strptime(data$Date, "%d/%m/%Y"))

# filter on the dates we want
startDate = as.Date(strptime("01/02/2007", "%d/%m/%Y"))
endDate = as.Date(strptime("02/02/2007", "%d/%m/%Y"))
timestamp <- timestamp[data$Date >= startDate & data$Date <= endDate]
data <- data[data$Date >= startDate & data$Date <= endDate, ]

# now prepare data$Time as Time type
data$Time <- strptime(data$Time, "%H:%M:%S")

data$Sub_metering_1 <- as.numeric(data$Sub_metering_1)
data$Sub_metering_2 <- as.numeric(data$Sub_metering_2)
data$Sub_metering_3 <- as.numeric(data$Sub_metering_3)

### STEP 2: plot it!
png("plot3.png", width=480, height=480)
plot(timestamp, data$Sub_metering_1, 
     type = "l",
     ylab = "Energy sub metering",
     xlab = "")
lines(timestamp, data$Sub_metering_2, col="red")
lines(timestamp, data$Sub_metering_3, col="blue")
legend("topright", 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("black", "red", "blue"), 
       lwd=1, cex=1)
dev.off()
