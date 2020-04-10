# Plot 2 code

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



# Creating plot 2

elecdata$datetime <- paste(elecdata$Date, elecdata$Time, sep=' ')
elecdata$datetime <- as.POSIXlt(strptime(elecdata$datetime,
                                         '%d/%m/%Y %H:%M:%S'))
    # Joining date and time in a single variable of appropriate type

par(cex.axis=.8, cex.lab=.8, cex.main=.9)

plot(elecdata$datetime, elecdata$Global_active_power, type='l',
     xlab='', ylab='Global Active Power (kilowatts)')



# Saving the plot to PNG

dev.copy(png, file='plot2.png', width=480, height=480)
dev.off()

