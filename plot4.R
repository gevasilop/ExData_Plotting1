rm(list=ls())
library(data.table); library(plyr); library(dplyr); library(magrittr)

consumption <- fread(file = 'household_power_consumption.txt', header = T, sep = ';', na.strings = '?', data.table = F)
consumption$Date %<>% as.Date("%d/%m/%Y")
consumption %<>% filter(Date >= '2007-02-01' & Date <= '2007-02-02')
consumption$datetime <- paste(consumption$Date, consumption$Time, sep = ' ')
consumption$datetime %<>% strptime('%Y-%m-%d %H:%M:%S', tz = 'GMT')
sapply(consumption, class)

par(mar= c(5,4,4,2)+0.1, mfrow = c(2,2))
with(consumption, {
  plot(datetime, Global_active_power, type = 'l', xlab = '', ylab = 'Global Active Power')
  plot(datetime, Voltage, type = 'l', xlab = 'datetime', ylab = 'Voltage')
  plot(datetime, Sub_metering_1, col = 'black', type = 'l', xlab = '', ylab = 'Energy sub metering')
  lines(datetime, Sub_metering_2, col = 'red', type = 'l')
  lines(datetime, Sub_metering_3, col = 'blue', type = 'l')
  legend("topright", cex = 1, bty = "n" , y.intersp = 1,lwd = 1, col = c("black", "red", "blue"), legend = c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3            '))
  plot(datetime, Global_reactive_power, type = 'l', xlab = 'datetime', ylab = 'Global_reactive_power')
})

dev.copy(png, 'plot4.png', width = 480, height = 480, )
dev.off()
