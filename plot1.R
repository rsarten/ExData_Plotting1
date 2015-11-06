###########################################################################################
# R script for producing Plot 1
# Assumes file 'household_power_consumption.txt' has been extracted
# from .zip and sits in same directory as script.
library(dplyr)
library(tidyr)
library(lubridate)
###########################################################################################
# Load in data and amalgamate date and time data
df_first <- read.table("./household_power_consumption.txt", sep=";", skip=66637, nrows=2880,
                       col.names = c("Date", "Time", "Global_active_power",
                                     "Global_reactive_power", "Voltage",
                                     "Global_intensity", "Sub_metering_1",
                                     "Sub_metering_2", "Sub_metering_3"), stringsAsFactors = F)

df <- df_first %>% mutate(date = paste(Date, Time, sep = " ")) %>% 
  select(date, Global_active_power:Sub_metering_3)
df$date <- dmy_hms(df$date)
###########################################################################################
# Plot 1
png("plot1.png", width = 480, height = 480, units = "px")
with(df, hist(Global_active_power, breaks=15, col='red',
              main="Global Active Power", 
              xlab="Global Active Power (kilowatts)"))
dev.off()
