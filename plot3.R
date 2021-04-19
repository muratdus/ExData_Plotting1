library(dplyr)


data <- read.table("./household_power_consumption.txt",sep =";",header = TRUE, na.strings = "?",stringsAsFactor = FALSE)
data$Date <- as.Date(data$Date,format = "%d/%m/%Y")

dat_2days <- data %>% filter(Date <= "2007-02-02" & Date >= "2007-02-01")
dat_2days <- dat_2days %>% mutate(Date_time = paste(dat_2days$Date,dat_2days$Time, sep = " "),.before= Date)
dat_2days$Date_time <- as.POSIXct(dat_2days$Date_time,tz="")
# or dat_2days$Date_time <- strptime(dat_2days$Date_time,format = "%Y-%m-%d %H:%M:%S",tz ="")

dat_2days <- dat_2days[,-2:-3]

#plot3
plot(x= dat_2days$Date_time,y = dat_2days$Sub_metering_1,type = "l",ylim=c(0,max(dat_2days$Sub_metering_1)),xlab = "",ylab="Energy sub metering")
par(new =TRUE)
plot(x= dat_2days$Date_time,y = dat_2days$Sub_metering_2,type = "l",ylim=c(0,max(dat_2days$Sub_metering_1)),col="red",xlab = "",ylab="")
par(new =TRUE)
plot(x= dat_2days$Date_time,y = dat_2days$Sub_metering_3,type = "l",ylim=c(0,max(dat_2days$Sub_metering_1)),col ="blue",xlab = "",ylab="")
legend("topright", c("Sub_metering1","Sub_metering2","Sub_metering3"),lty = 1,col = c("black","red","blue"))

#save plot3 to png 
dev.copy(png,file="plot3.png")
dev.off()
