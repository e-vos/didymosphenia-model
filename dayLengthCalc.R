# File: dayLengthCalc.R
# Author: Elliot V. Vosburgh
# Date: (last updated) 10 March 2023
# Description:
#   
#   This file contains calculations necessary for
#   generating a vector of day lengths based upon
#   a specific latitude and longitude. It uses the
#   `suncalc` package.

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

## Write data to comma-separated values (.csv) file with columns day_number, day_length, and difference
# write.csv(df, file = "day_lengths.csv", row.names = FALSE)
