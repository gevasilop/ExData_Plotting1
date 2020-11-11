rm(list=ls())
library(data.table); library(plyr); library(dplyr); library(magrittr)

consumption <- fread(file = 'household_power_consumption.txt', header = T, sep = ';', na.strings = '?', data.table = F)
consumption$Date %<>% as.Date("%d/%m/%Y")
consumption %<>% filter(Date >= '2007-02-01' & Date <= '2007-02-02')
consumption$datetime <- paste(consumption$Date, consumption$Time, sep = ' ')
consumption$datetime %<>% strptime('%Y-%m-%d %H:%M:%S', tz = 'GMT')
sapply(consumption, class)

par(mar= c(5,4,4,2)+0.1, mfrow = c(1,1))
hist(consumption$Global_active_power, col = 'red', main = 'Global Active Power', xlab = 'Global Active Power (kilowatts)')
dev.copy(png, 'plot1.png', width = 480, height = 480)
dev.off()
