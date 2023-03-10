# File: dayLengthCalc.R
# Author: Elliot V. Vosburgh
# Date: (last updated) 6 March 2023
# Description:
#   
#   This file contains calculations necessary for
#   generating a vector of day lengths based upon
#   a specific latitude and longitude. It uses the
#   `suncalc` package.

# ADD THIS TO THE MAIN SCRIPT FILE IF INCLUDING FROM THIS FILE:

# # Source other script files in the same directory
# source("dayLengthCalc.R")

library(suncalc)

# Define the latitude and longitude of the location of interest
lat <- 41.62
lon <- -71.62

# Define the start and end dates of the time period
start_date <- as.Date("2023-05-01")
end_date <- as.Date("2023-09-30")

# Generate a vector of dates for the time period
dates <- seq(from = start_date, to = end_date, by = "day")

# Compute the day lengths for each date
day_lengths <- sapply(dates, function(x) {
    st <- suncalc::getSunlightTimes(date = x, lat = lat, lon = lon)
    as.numeric(difftime(st$sunset, st$sunrise, units = "hours"))
})

# Create a data frame with day number, day length, and difference in day length from previous day
dayLenDataFrame <- data.frame(day_number = 1:length(day_lengths), 
                              day_length = day_lengths, 
                              difference = c(0, abs(diff(day_lengths))))

write.csv(df, file = "day_lengths.csv", row.names = FALSE)