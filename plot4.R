#Read in data
data<-read.table("household_power_consumption.txt",header=TRUE,sep=";")

#Format and clean data
x<-data
x<-x[!(x$Global_active_power=="?"),]   
x<-x[!(x$Sub_metering_1=="?"),]
x<-x[!(x$Sub_metering_2=="?"),]
x<-x[!(x$Sub_metering_3=="?"),]
x<-x[!(x$Voltage=="?"),]
x<-x[!(x$Global_reactive_power=="?"),]
      

x$Global_active_power<-as.numeric(as.character((x$Global_active_power)))
x$Global_reactive_power<-as.numeric(as.character((x$Global_reactive_power)))
x$Voltage<-as.numeric(as.character((x$Voltage)))
x$Sub_metering_1<-as.numeric(as.character((x$Sub_metering_1)))        
x$Sub_metering_2<-as.numeric(as.character((x$Sub_metering_2))) 
x$Sub_metering_3<-as.numeric(as.character((x$Sub_metering_3))) 

#Convert dates and subset by selected date range
x$Date<-as.Date(x$Date,format="%d/%m/%Y")
x.2007<-subset(x,Date>as.Date("2007-01-31")& Date<as.Date("2007-02-03"))
dateTime<-as.POSIXct(paste(x.2007$Date,as.character(x.2007$Time)))
x.2007<-data.frame(x.2007,dateTime)

#Format plot structure
par(mfcol=c(2,2))
par(cex=.75,cex.axis=.75,cex.lab=.75)

#Add plot 1
with(x.2007,plot(dateTime,Global_active_power,type="l",xlab=NA,ylab="Global Active Power"))


#Add plot 2
with(x.2007,plot(dateTime,Sub_metering_1,type="l",
                 xlab=NA,ylab="Energy sub metering",yaxt="n"))

with(x.2007,lines(dateTime,Sub_metering_2,col="red"))

with(x.2007,lines(dateTime,Sub_metering_3,col="blue"))

axis(2,at=c(0,10,20,30))

legend("topright",lty=c(1,1,1),bty="n",col=c("black","red","blue"),
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),cex=.85)

#Add plot 3
with(x.2007,plot(dateTime,Voltage,type="l",ylab="Voltage",xlab="datetime"))

#Add plot 4
with(x.2007,plot(dateTime,Global_reactive_power,type="l",xlab="datetime"))

#Copy plot to PNG
png("plot4.png")
par(mfcol=c(2,2))

#Add plot 1
with(x.2007,plot(dateTime,Global_active_power,type="l",xlab=NA,ylab="Global Active Power"))


#Add plot 2
with(x.2007,plot(dateTime,Sub_metering_1,type="l",
                 xlab=NA,ylab="Energy sub metering",yaxt="n"))

with(x.2007,lines(dateTime,Sub_metering_2,col="red"))

with(x.2007,lines(dateTime,Sub_metering_3,col="blue"))

axis(2,at=c(0,10,20,30))

legend("topright",lty=c(1,1,1),bty="n",col=c("black","red","blue"),
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

#Add plot 3
with(x.2007,plot(dateTime,Voltage,type="l",ylab="Voltage",xlab="datetime"))

#Add plot 4
with(x.2007,plot(dateTime,Global_reactive_power,type="l",xlab="datetime"))

dev.off()
