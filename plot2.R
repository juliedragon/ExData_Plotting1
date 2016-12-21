#plot2 is Global Active Power in kilowatts (0-6) by Day (Thur, Fri, Sat) (x-axis in black)
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

#plot the Global Active Power as a line by dateTimePOSIX variable and label axes
plot(gap$dateTimePOSIX, gap$Global_active_power, xlab = "", ylab = "Global Active Power (kilowatts)", type = "l")



