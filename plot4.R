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

data$Global_active_power <- as.numeric(data$Global_active_power)
data$Global_reactive_power <- as.numeric(data$Global_reactive_power)
data$Voltage <- as.numeric(data$Voltage)
data$Sub_metering_1 <- as.numeric(data$Sub_metering_1)
data$Sub_metering_2 <- as.numeric(data$Sub_metering_2)
data$Sub_metering_3 <- as.numeric(data$Sub_metering_3)

### STEP 2: plot it!
png("plot4.png", width=480, height=480)
par(mfrow = c(2,2))

# Plot 1
plot(timestamp, data$Global_active_power, 
     type = "l",
     ylab = "Global Active Power",
     xlab = "")

# Plot 2
plot(timestamp, data$Voltage, 
     type = "l",
     ylab = "Voltage",
     xlab = "datetime")

# Plot 3
plot(timestamp, data$Sub_metering_1, 
     type = "l",
     ylab = "Energy sub metering",
     xlab = "")
lines(timestamp, data$Sub_metering_2, col="red")
lines(timestamp, data$Sub_metering_3, col="blue")
legend("topright", 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("black", "red", "blue"), 
       lwd=1, cex=0.95, bty="n")

# Plot 4
plot(timestamp, data$Global_reactive_power, 
     type = "l",
     ylab = "Global_reactive_power",
     xlab = "datetime")

dev.off()
