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

#plot 1
png(filename="plot1.png", width=480, height=480)
hist(power$globalactivepower, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")
dev.off()