read.file <- function() {
  read.csv2(file = "data/household_power_consumption.txt",
            header = TRUE,
            sep = ";")
}

get.data <- function() {
  data <- read.file()
  data$DateTime <- strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S")
  data <- subset(data, DateTime >= "2007-02-01" & DateTime < "2007-02-03")
  data$Global_reactive_power <- as.numeric(as.character(data$Global_reactive_power))
  data$Voltage <- as.numeric(as.character(data$Voltage))
  data$Sub_metering_1 <- as.numeric(as.character(data$Sub_metering_1))
  data$Sub_metering_2 <- as.numeric(as.character(data$Sub_metering_2))
  data$Sub_metering_3 <- as.numeric(as.character(data$Sub_metering_3))
  data
}

draw.top.left.plot <- function(data) {
  with(data,
       plot(x = DateTime,
            y = Global_active_power,
            type = "l",
            ylab = "Global Active Power",
            xlab = ""))
}

draw.top.right.plot <- function(data) {
  with(data,
       plot(x = DateTime,
            y = Voltage,
            type = "l",
            ylab = "Voltage",
            xlab = "datetime"))
}

draw.bottom.left.plot <- function(data) {
  with(data,
       plot(x = DateTime,
            y = Sub_metering_1,
            type = "n",
            ylab = "Energy sub metering",
            xlab = ""))
  
  with(data,
       lines(x = DateTime,
             y = Sub_metering_1,
             col = "black"))
  
  with(data,
       lines(x = DateTime,
             y = Sub_metering_2,
             col = "red"))
  
  with(data,
       lines(x = DateTime,
             y = Sub_metering_3,
             col = "blue"))
  
  legend("topright",
         legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
         bty = "n",
         lty = 1,
         lwd = 2,
         col = c("black", "red", "blue"))
}

draw.bottom.right.plot <- function(data) {
  with(data,
       plot(x = DateTime,
            y = Global_reactive_power,
            type = "l",
            xlab = "datetime"))
}

electric.power.consumption <- get.data()

png(filename = "plot4.png", width = 480, height = 480)

Sys.setlocale(category = "LC_ALL", locale = "en_US")

par(mfrow = c(2, 2))

draw.top.left.plot(electric.power.consumption)
draw.top.right.plot(electric.power.consumption)
draw.bottom.left.plot(electric.power.consumption)
draw.bottom.right.plot(electric.power.consumption)

dev.off()