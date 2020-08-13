data <- read.table("household_power_consumption.txt", header = FALSE, skip = 66637,
                   nrows = 2880, sep = ';' )
head(data)
name_col <- read.table("household_power_consumption.txt", header = FALSE,
                    nrows = 1, sep = ';' )
names(data) <- name_col[1,]
data[['Date_Time']] = paste(data$Date, data$Time, sep = ' ')
data[['Date_Time']] = strptime(data[['Date_Time']], "%d/%m/%Y %H:%M:%S")
data$Global_active_power = as.numeric(data$Global_active_power)

png(file = "Plot1.png")
with(data, hist(Global_active_power, xlab = "Global Active Power (kilowatts)"
                ,col = "red", main = "Global Active Power"))
dev.off()

png(file = "Plot2.png")
with(data, plot(Date_Time, Global_active_power, type = 'l', 
                xlab = '', ylab = "Global Active Power (kilowatts)"))
dev.off()

data$Sub_metering_1 <- as.numeric(data$Sub_metering_1)
data$Sub_metering_2 <- as.numeric(data$Sub_metering_2)
data$Sub_metering_3 <- as.numeric(data$Sub_metering_3)

png(file = "Plot3.png")
with(data, plot(Date_Time, Sub_metering_1, type = 'l',
                col = "black", xlab = "", ylab = "Energy sub metering"))
with(data, lines(Date_Time, Sub_metering_2, col = 'red'))
with(data, lines(Date_Time, Sub_metering_3, col = 'blue'))
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty = 1, col = c("black", "red", "blue"))
dev.off()

png(file = "Plot4.png")
par(mfrow = c(2,2), mar = c(4,4,2,1))
with(data, plot(Date_Time, Global_active_power, type = 'l', 
                xlab = '', ylab = "Global Active Power"))
with(data,plot(Date_Time, Voltage , type = 'l', 
               xlab = 'datetime', ylab = "Voltage"))
with(data, plot(Date_Time, Sub_metering_1, type = 'l',
                col = "black", xlab = "", ylab = "Energy sub metering"))
with(data, lines(Date_Time, Sub_metering_2, col = 'red'))
with(data, lines(Date_Time, Sub_metering_3, col = 'blue'))
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty = 1, col = c("black", "red", "blue"))
with(data, plot(Date_Time, Global_active_power, type = 'l',
                col = "black", xlab = "datetime"))
dev.off()