#PLOT 2

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

#build plot 2
png("plot2.png")

plot2 <- plot(x = householdpower$DateTime, y = householdpower$Global_active_power,type = "l",
              xlab = "", ylab = "Global Active Power (kilowatts)")

dev.off()
