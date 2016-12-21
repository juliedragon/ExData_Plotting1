#plot3 is Subset metering measurements by Day (Thur, Fri, Sat) in the same graph
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

#plot all 3 submetering measures as a line by dateTimePOSIX variable and label axes
matplot(gap$dateTimePOSIX, gap[,c(7:9)], col = c("black", "red", "blue"), xlab = "", ylab = "Energy sub metering", type="l", lty = 1, xaxt= "n")
day <- gap$dateTimePOSIX
axis.POSIXct(1, at = seq(day[1], day[2880]+1000, by = "day"))
legend ("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), lty = 1, xpd = FALSE,inset=0.1,bty="n",cex=0.60)

