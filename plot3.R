read.file <- function() {
  read.csv2(file = "data/household_power_consumption.txt",
            header = TRUE,
            sep = ";")
}

get.data <- function() {
  data <- read.file()
  data$DateTime <- strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S")
  data <- subset(data, DateTime >= "2007-02-01" & DateTime < "2007-02-03")
  data$Sub_metering_1 <- as.numeric(as.character(data$Sub_metering_1))
  data$Sub_metering_2 <- as.numeric(as.character(data$Sub_metering_2))
  data$Sub_metering_3 <- as.numeric(as.character(data$Sub_metering_3))
  data
}

electric.power.consumption <- get.data()

png(filename = "plot3.png", width = 480, height = 480)

Sys.setlocale(category = "LC_ALL", locale = "en_US")

with(electric.power.consumption,
     plot(x = DateTime,
          y = Sub_metering_1,
          type = "n",
          ylab = "Energy sub metering",
          xlab = ""))

with(electric.power.consumption,
     lines(x = DateTime,
           y = Sub_metering_1,
           col = "black"))

with(electric.power.consumption,
     lines(x = DateTime,
           y = Sub_metering_2,
           col = "red"))

with(electric.power.consumption,
     lines(x = DateTime,
           y = Sub_metering_3,
           col = "blue"))

legend("topright",
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty = 1,
       col = c("black", "red", "blue"))

dev.off()