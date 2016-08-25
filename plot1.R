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

png(filename = "plot1.png", width = 480, height = 480)

with(electric.power.consumption,
     hist(Global_active_power,
          main = "Global Active Power",
          col = "red",
          xlab = "Global Active Power (kilowatts)"))

dev.off()