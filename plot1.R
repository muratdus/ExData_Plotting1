library(dplyr)


data <- read.table("./household_power_consumption.txt",sep =";",header = TRUE, na.strings = "?",stringsAsFactor = FALSE)
data$Date <- as.Date(data$Date,format = "%d/%m/%Y")

dat_2days <- data %>% filter(Date <= "2007-02-02" & Date >= "2007-02-01")
dat_2days <- dat_2days %>% mutate(Date_time = paste(dat_2days$Date,dat_2days$Time, sep = " "),.before= Date)
dat_2days$Date_time <- as.POSIXct(dat_2days$Date_time,tz="")
# or dat_2days$Date_time <- strptime(dat_2days$Date_time,format = "%Y-%m-%d %H:%M:%S",tz ="")

dat_2days <- dat_2days[,-2:-3]
#plot1
hist(dat_2days$Global_active_power,col ="red",xlab = "Global Active Power (kilowatts)",main = "Global Active Power")

#save to png by 480x480px
dev.copy(png,file="plot1.png")
dev.off()
