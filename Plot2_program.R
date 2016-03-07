# Text file was downloaded 
# to working directory and renamed "power2.txt"

#install lubridate
install.packages("lubridate")

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

#PLOT2
with(dfA, {
  plot(nt, Global_active_power)
  lines(nt,Global_active_power)
})
dev.off()