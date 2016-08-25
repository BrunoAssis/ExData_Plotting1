read.file <- function() {
  read.csv2(file = "data/household_power_consumption.txt",
            header = TRUE,
            sep = ";")
}

get.data <- function() {
  data <- read.file()
  data$DateTime <- strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S")
  data <- subset(data, DateTime >= "2007-02-01" & DateTime < "2007-02-03")
  data$Global_active_power <- as.numeric(as.character(data$Global_active_power))
  data
}

electric.power.consumption <- get.data()

png(filename = "plot2.png", width = 480, height = 480)

Sys.setlocale(category = "LC_ALL", locale = "en_US")

with(electric.power.consumption,
     plot(x = DateTime,
          y = Global_active_power,
          type = "l",
          ylab = "Global Active Power (kilowatts)",
          xlab = ""))

dev.off()