# Text file was downloaded 
# to working directory and renamed "power2.txt"

#install lubridate & reshape 2
install.packages("lubridate")
install.packages("reshape2")

#fIndout classes & save for next step
tab5rows <- read.table("power2.txt", header = TRUE, sep = ";" , nrows = 5)
A<-sapply(tab5rows, class)

#read subset of table from 1/2/2007 to 2/2/2007
dfA<-read.table("power2.txt", header = F, sep = ";" , skip=66636, 
                nrows = 2881, colClasses = c(A) )
#pass names
names(dfA)<-names(tab5rows)

#paste date & time
l<-paste(dfA$Date, dfA$Time)

#parse date & time thru lubridate
library(lubridate)
nt<-dmy_hms(l)

#cbind to dfA
dfA<-cbind(dfA, nt)

#PLOT4
#format plotter
par(mfrow = c(2, 2))
#plot 1-4
with(dfA, {
  plot(nt, Global_active_power)
  lines(nt,Global_active_power)
})

#2
with(dfA, {
  plot(nt, Voltage)
  lines(nt,Voltage)
})

#3
#subset what we need
dfB<-dfA[,c(7,8,9,10)]
#melt it
library("reshape2")
m<-melt(dfB, id="nt")
names(m)[3]<-"Sub_metering"
#plot nt v rest, lines on m1-3
with(m,plot(nt, Sub_metering))
with(subset(m,variable=="Sub_metering_1"), lines(nt, Sub_metering, col="black"))
with(subset(m,variable=="Sub_metering_2"), lines(nt, Sub_metering, col="red"))
with(subset(m,variable=="Sub_metering_3"), lines(nt, Sub_metering, col="blue"))
legend("topright", pch=1, col=c("black", "red","blue"),
       legend=c("Sub_metering1", "Sub_metering2", "Sub_metering3"))
#4
with(dfA, {
  plot(nt, Global_reactive_power)
  lines(nt,Global_reactive_power)
})
dev.off()