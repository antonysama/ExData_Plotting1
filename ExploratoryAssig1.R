#Q1Have total emissions from PM2.5 decreased from 1999 to 2008? 
#Using the base plottin
#Downloaded and extracted two zipped files in working directory. 
#Reading the two files and subsetting Emissions & year
Code<-readRDS("Code2.rds")
pm25<-readRDS("PM25(2).rds")
pm25<-pm25[,c(4,6)]
#dplyr to sum emissions by year 
library("dplyr")
e<-pm25%>%
  group_by(year)%>%
  summarise_each(funs(sum, mean))
#base plot & save
with(e, plot(year, sum, type="b", main="US total emissions from PM2.5"))
dev.copy(png,'plot1.png')
dev.off()

#Q2 Have total emissions from PM2.5 decreased in the  Baltimore City?
#read & subset Baltimire emisions by year
pm25<-readRDS("PM25(2).rds")
q2<-pm25[pm25$fips=="24510",c(4,6)]
#dplyr to sum emissions by year
library("dplyr")
  q2<-q2%>%
    group_by(year)%>%
    summarise_each(funs(sum))
#base plot & save
with(q2, plot(year, Emissions,type="b", main="Total PM2.5 in Baltimore City"))
dev.copy(png,'plot2.png')
dev.off()

#Q3 Which type of emissions has decreased for Baltimore city?
#read and subset Baltimore emissions by year by type
q3<-pm25[pm25$fips=="24510",c(4:6)]
#dplyr to sum emissions by type & year 
library("dplyr")
q3<-q3%>%
  group_by(type, year)%>%
  summarise_each(funs(sum))
library("ggplot2")
qplot(year, Emissions, data=q3, colour=type, geom = c("point", "smooth"),
      main="Which Source of emissions have decreased for Baltimore city")
dev.copy(png,'plot3.png')
dev.off()     

#Q4. How have emissions from coal combustion changed across the US 
#subset df contating Comb & Coal
Code2<-Code[grep("Comb(.*)Coal", Code$EI.Sector),]
SCC2<-Code2[,1]
#after merging check that no. observations are <pm25
m2<-merge(Code2,pm25, by.x="SCC", by.y="SCC")
#get what we need
m3<-m2[,c(18,20)]
#dplyr by year, Emissions
library("dplyr")
m3<-m3%>%
  group_by(year)%>%
  summarise_each(funs(sum))
#ggplot by year
library("ggplot2")
qplot(year, Emissions, data=m3, geom = c("point", "smooth"),
      main="How have emissions from coal combustion changed across the US")
dev.copy(png,'plot4.png')
dev.off()  

#Q5 How have emissions from motor vehicle sources changed in Baltimore City
#subset Baltimore & On-road
q5<-pm25[pm25$fips=="24510" & pm25$type=="ON-ROAD",]
#take yEAR and emmissions
q5<-q5[,c(4,6)]
#by year, Emissions
library("dplyr")
q5<-q5%>%
  group_by(year)%>%
  summarise_each(funs(sum))
#ggplot by year
library("ggplot2")
qplot(year, Emissions, data=q5,geom = c("point", "smooth"),
  main="How have emissions from motor vehicle sources changed in Baltimore City")
dev.copy(png,'plot5.png')
dev.off() 
     
#Q6 Baltimore & LA county, on-road
q6<-pm25[pm25$fips==c("24510","06037") & pm25$type=="ON-ROAD",]
#take yEAR , emmissions & fips
q6<-q6[,c(1,4,6)]
#by fips, fyear, Emissions
q6<-q6%>%
  group_by(fips,year)%>%
  summarise_each(funs(sum))
#ggplot by year
library("ggplot2")
qplot(year, Emissions, data=q6, facets=.~fips, geom = c("point", "smooth"),
      main="Onroad emissions  from Baltimore (#24510) & LA county(#06037)")
dev.copy(png,'plot6.png')
dev.off() 
