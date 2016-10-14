# define a custom date type 
setAs("character","myDate", function(from) as.Date(from, format="%d/%m/%Y") )

#read data in from txt file.  Skip lines until you hit 2/1/2007 and read only 2880 (2 days worth of minutes)
# use colClasses to speed up the reading
power <- read.table(file="household_power_consumption.txt", sep=";",skip = 66637,nrows=2880,header = F,
                    colClasses = c("myDate", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"), na.strings="?")

# set column names
colnames(power) <- c("date", "time", "globalactivepower", "globalreactivepower", "voltage", "globalintensity", "submetering1", "submetering2", "submetering3")

# combine the date and time columns
power$gooddate <- as.POSIXct(paste(power$date, power$time))


# plot 4
png(filename="plot4.png", width=480, height=480)
par("mfrow" = c(2,2))
with(power, plot(gooddate,globalactivepower, type="l", ylab="Global Active Power", xlab=""))

with(power, plot(gooddate,voltage, type="l", ylab="Voltage", xlab="datetime"))

with(power, plot(gooddate, submetering1, type="l", ylab="Energy sub metering", xlab=""))
with(power, lines(gooddate, submetering2, type="l", col="red"))
with(power, lines(gooddate, submetering3, type="l", col="blue"))
with(power, legend("topright", bty="n", c("sub_metering_1", "sub_metering_2", "sub_metering_3"), lty=c(1,1,1),col=c("black", "red", "blue")))

with(power, plot(gooddate,globalreactivepower, type="l", ylab="Global_reactive_power", xlab="datetime"))
dev.off()
