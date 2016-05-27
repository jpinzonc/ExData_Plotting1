# This script creates a graph for the Global Active Power between February 1st and February 2nd 2007:
# Read the lines online of Feb 1 and 2 2007:
# 1. read all lines in the file:
liNeas <- readLines("household_power_consumption.txt")
# 2. create a vector with only the dates of interes
vecN <-   grep("^[1|2]/2/2007", liNeas )
# 3 read the lines of interes from the file:
df_2days <- read.table(text=liNeas[vecN], header = F, sep=";",col.names = c("Date", "Time", "Global_active_power", 
                                  "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", 
                                  "Sub_metering_2", "Sub_metering_3"))
# 4. create a new colum combining the date and time (ntime):
df_2days$ntime= (as.POSIXct(strptime(paste(df_2days$Date, df_2days$Time,sep="."), tz="America/Chicago", format="%d/%m/%Y.%H:%M:%OS")))
# 5. convert the column Global_active_power to numeric:
df_2days$Global_active_power<-as.numeric(as.character(df_2days$Global_active_power))

# PLOT2:
png("plot2.png", width = 480, height = 480)
plot(df_2days$ntime, df_2days$Global_active_power, type="l", ylab="Global Active Power (kilowatts)", xlab="")
dev.off()
