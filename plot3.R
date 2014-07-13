#Read in data
data<-read.table("household_power_consumption.txt",header=TRUE,sep=";")

#Format and clean data
x<-data
x<-x[!(x$Sub_metering_1=="?"),]
x<-x[!(x$Sub_metering_2=="?"),]
x<-x[!(x$Sub_metering_3=="?"),]
x$Date<-as.Date(x$Date,format="%d/%m/%Y")
x$Sub_metering_1<-as.numeric(as.character((x$Sub_metering_1)))        
x$Sub_metering_2<-as.numeric(as.character((x$Sub_metering_2))) 
x$Sub_metering_3<-as.numeric(as.character((x$Sub_metering_3))) 

#Subset data by selected dates and format time field
x.2007<-subset(x,Date>as.Date("2007-01-31")& Date<as.Date("2007-02-03"))
dateTime<-as.POSIXct(paste(x.2007$Date,as.character(x.2007$Time)))
x.2007<-data.frame(x.2007,dateTime)

#Create plot and add legend
par(cex=.85,cex.axis=.85,cex.lab=.85)

with(x.2007,plot(dateTime,Sub_metering_1,type="l",
                 xlab=NA,ylab="Energy sub metering",yaxt="n"))

with(x.2007,lines(dateTime,Sub_metering_2,col="red"))

with(x.2007,lines(dateTime,Sub_metering_3,col="blue"))

axis(2,at=c(0,10,20,30))
legend("topright",lty=c(1,1,1),col=c("black","red","blue"),
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),cex=.85)

#Copy plot to PNG
png("plot3.png")

with(x.2007,plot(dateTime,Sub_metering_1,type="l",
                 xlab=NA,ylab="Energy sub metering",yaxt="n"))

with(x.2007,lines(dateTime,Sub_metering_2,col="red"))

with(x.2007,lines(dateTime,Sub_metering_3,col="blue"))

axis(2,at=c(0,10,20,30))
legend("topright",lty=c(1,1,1),col=c("black","red","blue"),
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

dev.off()

