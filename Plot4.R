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
df_2days$ntime= (as.POSIXct(strptime(paste(inSub$Date,inSub$Time,sep="."), tz="America/Chicago", format="%d/%m/%Y.%H:%M:%OS")))
# 5. convert the column Global_active_power to numeric:
df_2days$Global_active_power<-as.numeric(as.character(inSub$Global_active_power))

# PLOT4:
png("plot4.png", width = 480, height = 480)
# Create a canvas for 4 graphs:
par(mfrow=c(2,2), cex=0.8)
# Add the first plot:
plot(df_2days$ntime, df_2days$Global_active_power, type="l", ylab="Global Active Power (kilowatts)", xlab="")
# second
plot(df_2days$ntime, df_2days$Voltage, type="l", ylab="Voltage", xlab="datetime")
# third:
plot(df_2days$ntime, df_2days$Sub_metering_1, type="l", ylab="Energy sub metering", xlab="")
lines(df_2days$ntime, df_2days$Sub_metering_2, type="l", col="red")
lines(df_2days$ntime, df_2days$Sub_metering_3, type="l", col="blue")
legend("topright",lwd=2, col=c("black", "red", "blue"),cex=0.8,legend=c("Sub_metering_1","Sub_metering_2", "Sub_metering_3" ))
# forth
plot(df_2days$ntime, df_2days$Global_reactive_power, type="l", ylab="Global_reactive_power", xlab="datetime")
# close
dev.off()
