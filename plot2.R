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

### STEP 2: plot it!
png("plot2.png", width=480, height=480)
plot(timestamp, data$Global_active_power, 
     type = "l",
     ylab = "Global Active Power (kilowatts)",
     xlab = "")
dev.off()
