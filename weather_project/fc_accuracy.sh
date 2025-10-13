#!/bin/bash

# Make file executable with: chmod +x fc_accuracy.sh
# Run script in terminal with: ./fc_accuracy.sh

# This script calculates the forecast accuracy based on the previous day's forecast and today's observed temperature.
# It appends the accuracy data to a historical_fc_accuracy.tsv file.

# Calc forecast accuracy
# extracts a specific forecast temperature value from the second-to-last line of the rx_poc.log file and saves it to the variable yesterday_fc
# retrieves the value that is located in the 5th column of the second-to-last line of your log file.
yesterday_fc=$(tail -2 rx_poc.log | head -1 | cut -d " " -f5)
today_temp=$(tail -1 rx_poc.log | cut -d " " -f4)
accuracy=$(($yesterday_fc-$today_temp))
echo "accuracy is $accuracy"

# Assign a lable to each forecast based on accuracy (label ranges in accuracy)
if [ -1 -le $accuracy ] && [ $accuracy -le 1 ]
then
   accuracy_range=excellent
elif [ -2 -le $accuracy ] && [ $accuracy -le 2 ]
then
    accuracy_range=good
elif [ -3 -le $accuracy ] && [ $accuracy -le 3 ]
then
    accuracy_range=fair
else
    accuracy_range=poor
fi

echo "Forecast accuracy is $accuracy"

# Append a record to the historical forecast accuracy file
row=$(tail -1 rx_poc.log)
year=$( echo $row | cut -d " " -f1)
month=$( echo $row | cut -d " " -f2)
day=$( echo $row | cut -d " " -f3)
echo -e "$year\t$month\t$day\t$today_temp\t$yesterday_fc\t$accuracy\t$accuracy_range" >> historical_fc_accuracy.tsv
