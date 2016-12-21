#Code to read in data from the UC Irvine Machine Learning Repository,and plot certain 
#features from the Electric power consumption dataset
#plot1 is Global Active Power in kilowatts (0-6), by Frequency (0-1200) in red
#read data file, reclassify data, and filter by date
condata <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", stringsAsFactors = FALSE, colClasses =c("character","character", "character","character","character", "character", "character", "character", "character"))
startDate = as.Date("2007-02-01")
endDate = as.Date("2007-02-02")
date <- as.Date(condata$Date, format = "%d/%m/%Y")

#subset the gap data by the date range
dateFilter <- date >= startDate & date <= endDate

#subset the gap data as numeric class and plot
gap <- as.numeric(condata[dateFilter, "Global_active_power"])
hist(gap, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", col = "red")
        

