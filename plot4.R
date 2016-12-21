#plot4 is a collection of plots 2 then 3, and two new plots
#run common elements of plots 2 and 3 to read, filter, and sort days
#read data file, reclassify data, and filter by date
condata <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", stringsAsFactors = FALSE, colClasses =c("character","character", "character","character","character", "character", "character", "character", "character"))
startDate = as.Date("2007-02-01")
endDate = as.Date("2007-02-02")
date <- as.Date(condata$Date, format = "%d/%m/%Y")

#subset the gap data by the date range
dateFilter <- date >= startDate & date <= endDate

#plot "Thur" at 00:01 to "Fri" at 24:00
#first make a new column combining the data and time
gap <- condata[dateFilter,]
gap$dateTime<-apply(gap,1,function(row) {paste0(row["Date"]," ",row["Time"])})

#set this variable as POSIX with the correct format then order them
gap$dateTimePOSIX <- as.POSIXct(gap$dateTime, format="%d/%m/%Y %H:%M:%S",tz="EST")
gap<-gap[order(gap$dateTimePOSIX),]

#comand to define the parameters of the plots and stack them by column
par(mfcol=c(2,2))

#plot 2, the Global Active Power as a line by dateTimePOSIX variable and label axes
plot(gap$dateTimePOSIX, gap$Global_active_power, xlab = "", ylab = "Global Active Power (kilowatts)", type = "l")

#plot 2, all 3 submetering measures as a line by dateTimePOSIX variable and label axes
matplot(gap$dateTimePOSIX, gap[,c(7:9)], col = c("black", "red", "blue"), xlab = "", ylab = "Energy sub metering", type="l", lty = 1, xaxt= "n")
day <- gap$dateTimePOSIX
axis.POSIXct(1, at = seq(day[1], day[2880]+1000, by = "day"))

#define legend, with submetering colors as black, red, and blue
legend ("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), lty = 1, xpd = FALSE,inset=0.2,bty="n",cex=0.60)

#create new plot of gap$dateTimePOSIX called "datetime" by Voltage
plot(gap$dateTimePOSIX, gap$Voltage, xlab = "datetime", ylab = "Voltage", type = "l")

#create new plot of gap$dateTimePOSIX called "datetime" by Global_reactive_power
plot(gap$dateTimePOSIX, gap$Global_reactive_power, xlab = "datetime", ylab = "Global_reactive_power", type = "l", yaxt = "n",cex=0.5)
axis(side=2, at = seq(0, 0.5, 0.1),labels=seq(0, 0.5, 0.1),cex.axis=0.7)
