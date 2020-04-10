# Plot 3 code

# Getting and reading the data

setwd("~/Desktop/Data Science course/4. Exploratory Data Analysis/Project 1")
    # my local working directory

if (!file.exists('household_power_consumption.txt')){
    fileUrl <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
    download.file(fileUrl, destfile = 'exdata_data_household_power_consumption.zip',
                  method='curl')
    
    unzip('exdata_data_household_power_consumption.zip')
        # The result is a file named: household_power_consumption.txt
}

library(sqldf)

system.time({
    elecdata <- read.csv.sql( 'household_power_consumption.txt', header=TRUE, sep=';',
                              sql = "SELECT * FROM file WHERE Date IN ('1/2/2007', '2/2/2007') ")
})



# Creating plot 3

elecdata$datetime <- paste(elecdata$Date, elecdata$Time, sep=' ')
elecdata$datetime <- as.POSIXlt(strptime(elecdata$datetime,
                                         '%d/%m/%Y %H:%M:%S'))
    # Joining date and time in a single variable of appropriate type

par(cex.axis=.8, cex.lab=.8, cex.main=.9)

with(elecdata, {
    plot(datetime, Sub_metering_1, type='n', xlab='', ylab='Energy sub meterings')
    
    points(datetime, Sub_metering_1, type='l')
    points(datetime, Sub_metering_2, type='l', col='red')
    points(datetime, Sub_metering_3, type='l', col='blue')
    
    legend('topright', legend=c('Sub_metering_1','Sub_metering_2','Sub_metering_3'),
           col=c('black', 'red', 'blue'), lty=1, cex=.8)
})



# Saving the plot to PNG

dev.copy(png, file='plot3.png', width=480, height=480)
dev.off()

