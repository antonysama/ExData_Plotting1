install.packages("lubridate")
install.packages("reshape2")
#fIndout cases
tab5rows <- read.table("power2.txt", header = TRUE, sep = ";" , nrows = 5)
A<-sapply(tab5rows, class)
V<-names(tab5rows)

#read table and subest from 1/2/2007 untill end of 2/2/2007
dfA<-read.table("power2.txt", header = F, sep = ";" , skip=66636, 
                nrows = 2881, colClasses = c(A) )#maybe add na.strings="?"
#pass names
names(dfA)<-names(tab5rows)

#paste date & time
l<-paste(dfA$Date, dfA$Time)
#parse date & time thru lubridate
library(lubridate)
nt<-dmy_hms(l)
#cbind to dfA
dfA<-cbind(dfA, nt)
#[alternative]:dataset$DateTime <- strptime(paste(dataset$Date, dataset$Time), "%d/%m/%Y %H:%M:%S")


#create png template
png(filename="plot1.png", width=480, height=480)

#PLOT#1
png(filename="plot1.png", width=480, height=480) or
png("Plot1.png", width = 480, height = 480, units = "px", bg = "white")
par(mar= c(4, 4, 2, 1))

hist(dfA[,3], col = "red",breaks = 12, main = "GlobalActivePower", 
     xlab = "GlobalActivePower", ylab="Frequency")
dev.off()

## Alternative:Save the plot to the appropriate file.
dev.copy(png,'plot2.png')

#PLOT2
png(filename="plot2.png", width=480, height=480)
with(dfA, plot(nt, Global_active_power, type = 'l'))
dev.off()

#PLOT3 
#subset what we need
dfB<-dfA[,c(7,8,9,10)]
#melt it
library("reshape2")
m<-melt(dfB, id="nt")
names(m)[3]<-"Sub_metering"
#plot nt v rest, lines on m1-3
with(m, plot(nt, Sub_metering, xlab="", ylab="Energy sub metering", type = 'l'))
with(subset(m,variable=="Sub_metering_1"), lines(nt, Sub_metering, col="black"))
with(subset(m,variable=="Sub_metering_2"), lines(nt, Sub_metering, col="red"))
with(subset(m,variable=="Sub_metering_3"), lines(nt, Sub_metering, col="blue"))
legend("topright", pch=1, col=c("black", "red","blue"),
       legend=c("Sub_metering1", "Sub_metering2", "Sub_metering3"))
dev.off()
#alternative:
with(dataset, plot(DateTime, Sub_metering_1, xlab="", ylab="Energy sub metering", type='l')) 
with(dataset, lines(DateTime, Sub_metering_2, col='red')) 
with(dataset, lines(DateTime, Sub_metering_3, col='blue'))
legend("topright", col=c('black', 'red', 'blue'), legend=c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'), lty=1)


#PLOT4
#format plotter
par(mfrow = c(2, 2))
#plot 1-4
with(dfA, {
  plot(nt, Global_active_power)
  lines(nt,Global_active_power)
})

#2
with(dfA, plot(nt, Voltage, xlab="datetime", ylab="Voltage", type='l')

#3
#subset what we need
dfB<-dfA[,c(7,8,9,10)]
#melt it
library("reshape2")
m<-melt(dfB, id="nt")
names(m)[3]<-"Sub_metering"
#plot nt v rest, lines on m1-3
with(m, plot(nt, Sub_metering, xlab="", ylab="Energy sub metering", type = 'l'))
with(subset(m,variable=="Sub_metering_1"), lines(nt, Sub_metering, col="black"))
with(subset(m,variable=="Sub_metering_2"), lines(nt, Sub_metering, col="red"))
with(subset(m,variable=="Sub_metering_3"), lines(nt, Sub_metering, col="blue"))
legend("topright", pch=1, col=c("black", "red","blue"),
       legend=c("Sub_metering1", "Sub_metering2", "Sub_metering3"))
#4
with(dfA, plot(nt, Global_reactive_power, xlab="datetime", 
          ylab="Global_reactive_power", type='l'))
dev.off()
