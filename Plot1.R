# This script creates a graph for the Global Active Power between February 1st and February 2nd 2007:
# Read the lines online of Feb 1 and 2 2007:
# 1. read all lines in the file:
liNeas <- readLines("household_power_consumption.txt")
# 2. create a vector with only the dates of interes
vecN <-   grep("^[1|2]/2/2007", liNeas )
# 3.1. read the lines of interes from the file:
df_2days <- read.table(text=liNeas[vecN], header = F, sep=";",col.names = c("Date", "Time", "Global_active_power", 
                                  "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", 
                                  "Sub_metering_2", "Sub_metering_3"))
# 3.2. Optional: create a new colum combining the date and time:
inSub$ntime= (as.POSIXct(strptime(paste(inSub$Date,inSub$Time,sep="."), tz="America/Chicago", format="%d/%m/%Y.%H:%M:%OS")))
# 4. Convert the column Global_active_power to numeric:
inSub$Global_active_power<-as.numeric(as.character(inSub$Global_active_power))

# PLOT1:
png("plot1.png", width = 480, height = 480)
hist(inSub$Global_active_power, col ="red", xlab="Global Active Power (kilowatts)", main="Global Active Power")
dev.off()

