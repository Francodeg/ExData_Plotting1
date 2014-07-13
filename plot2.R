#Read in data
data<-read.table("household_power_consumption.txt",header=TRUE,sep=";")

#Format and clean data
x<-data
x<-x[!(x$Global_active_power=="?"),]   
x$Date<-as.Date(x$Date,format="%d/%m/%Y")
x$Global_active_power<-as.numeric(as.character((x$Global_active_power)))        

#Subset data by selected dates and format time field
x.2007<-subset(x,Date>as.Date("2007-01-31")& Date<as.Date("2007-02-03"))
dateTime<-as.POSIXct(paste(x.2007$Date,as.character(x.2007$Time)))
x.2007<-data.frame(x.2007,dateTime)

#Create plot
par(cex=.85,cex.axis=.85,cex.lab=.85)
with(x.2007,plot(dateTime,Global_active_power,type="l",xlab=NA,ylab="Global Active Power (kilowatts)"))

#Copy plot to PNG
png("plot2.png")

with(x.2007,plot(dateTime,Global_active_power,type="l",xlab=NA,ylab="Global Active Power (kilowatts)"))

dev.off()