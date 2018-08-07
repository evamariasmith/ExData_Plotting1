#PLOT 4

#read in file
file <- "household_power_consumption.txt"
householdpower <- read.table(file, header = FALSE, sep = ";", skip = 1, colClasses = 
                               c(rep("character", 2), rep("numeric", 7)), na.strings = "?")
cnames <- readLines(file, 1)
cnames <- strsplit(cnames, ";", fixed = TRUE)
names(householdpower) <- cnames[[1]]
householdpower <- householdpower[householdpower$Date %in% c("1/2/2007", "2/2/2007"), 
                                 ]
head(householdpower)

#convert date and time into date/time classes
householdpower$DateTime <- paste(householdpower$Date, householdpower$Time)
householdpower$DateTime <- strptime(householdpower$DateTime, "%d/%m/%Y %H:%M:%S")

#build plot 4
png("plot4.png")

#split into 4 plotting areas
par(mfcol = c(2,2))

#create mini plot 1 - Global Active Power v Time
plot(x = householdpower$DateTime, y = householdpower$Global_active_power,type = "l",
     xlab = "", ylab = "Global Active Power")

#create mini plot 2 - Energy Sub Metering v Time
plot(x = householdpower$DateTime, y = householdpower$Sub_metering_1, type = "n",
     xlab = "", ylab = "Energy Sub Metering")
lines(x = householdpower$DateTime, y = householdpower$Sub_metering_1)
lines(x = householdpower$DateTime, y = householdpower$Sub_metering_2, col = "red")
lines(x = householdpower$DateTime, y = householdpower$Sub_metering_3, col = "blue")
legend("topright", legend = c("Sub Metering 1", "Sub Metering 2", "Sub Metering 3"), 
       lty = 1, col = c("black", "red", "blue"), bty = "n")

#create mini plot 3 - Voltage v Time
plot(x = householdpower$DateTime, y = householdpower$Voltage, type = "l",
     xlab = "DateTime", ylab = "Voltage")

#create mini plot 4 - Global Reactive Power v Time
plot(x = householdpower$DateTime, y = householdpower$Global_reactive_power, type = "l",
     xlab = "DateTime", ylab = "Global Reactive Power")

dev.off()