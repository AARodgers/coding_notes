#!/bin/bash

curl -s "wttr.in/$city?T" --output weather_report

#To extract Current Temperature
obs_temp=$(curl -s "wttr.in/$city?T" | grep -m 1 '°.' | grep -Eo -e '-?[[:digit:]].*')
echo "The current Temperature of $city: $obs_temp"

# To extract the forecast tempearature for noon tomorrow
fc_temp=$(curl -s "wttr.in/$city?T" | head -23 | tail -1 | grep '°.' | cut -d 'C' -f2 | grep -Eo -e '-?[[:digit:]].*')
echo "The forecasted temperature for noon tomorrow for $city : $fc_temp C"

#Assign Country and City to variable TZ
TZ='Morocco/Casablanca'

# Use command substitution to store the current day, month, and year in corresponding shell variables:
day=$(TZ='Morocco/Casablanca' date -u +%d)
month=$(TZ='Morocco/Casablanca' date +%m)
year=$(TZ='Morocco/Casablanca' date +%Y)

# Log the weather
record=$(echo -e "$year\t$month\t$day\t$obs_temp\t$fc_temp C")
echo $record>>rx_poc.log

# Run script in terminal with: ./rx_poc.sh

# Create a cron job to run the script every day at 12pm:
# Edit the crontab file:
# crontab -e
# Add the following line at the end of the file:
# 0 6 * * * /home/project/rx_poc.sh
# Save the file and quit the editor.
