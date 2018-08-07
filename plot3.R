#PLOT 3

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

#build plot 3
png("plot3.png")

plot3 <- plot(x = householdpower$DateTime, y = householdpower$Sub_metering_1, type = "n",
              xlab = "", ylab = "Energy Sub Metering")
lines(x = householdpower$DateTime, y = householdpower$Sub_metering_1)
lines(x = householdpower$DateTime, y = householdpower$Sub_metering_2, col = "red")
lines(x = householdpower$DateTime, y = householdpower$Sub_metering_3, col = "blue")
legend("topright", legend = c("Sub Metering 1", "Sub Metering 2", "Sub Metering 3"), 
       lty = 1, col = c("black", "red", "blue"))

dev.off()