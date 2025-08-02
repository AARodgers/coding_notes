#!/bin/bash

# Purpose of script: Add a new column to a CSV file with a specified value.
# Will use arrays and access data with for loops.

# 1. Create a bash script file and make it executable
# echo '#!/bin/bash' > csv_add_column.sh
# chmod u+x csv_add_column.sh ( makes the script executable)

# 2. To get the csv file from a url, save it as a variable
# csv_file="https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-LX0117EN-SkillsNetwork/labs/M3/L2/arrays_table.csv"
# wget $csv_file

# 3. View csv file
# cat arrays_table.csv

# 4. Parse table columns into 3 arrays
# Note: Use command substitution, the cut command, and the notation for creating an array from a list of elements.
# Returns the first column (field) from every line in the CSV.
csv_file="./arrays_table.csv"

# parse table columns into 3 arrays
column_0=($(cut -d "," -f 1 $csv_file))
column_1=($(cut -d "," -f 2 $csv_file))
column_2=($(cut -d "," -f 3 $csv_file))

# print first array
echo "Displaying the first column:"
echo "${column_0[@]}"

# Notes on code:
# cut -d "," -f 1 $csv_file

# cut: a command-line tool used to extract sections from lines of a file.

# -d ",": sets the delimiter to a comma (,), meaning we are working with a CSV (Comma-Separated Values) file.

# -f 1: selects the first field (column) of each line.

# $csv_file: the name of the CSV file you're reading from (assumed to be a variable previously defined).

# $(...): command substitution.

# Runs the command inside and captures its output.

# (...): array constructor in bash.

# The output from cut is split into words and saved as elements of an array.



# 4. Create a new array as the difference of the third and second columns.

## Create a new array as the difference of columns 1 and 2
# initialize array with header
column_3=("column_3")
# get the number of lines in each column
nlines=$(cat $csv_file | wc -l)
echo "There are $nlines lines in the file"
# populate the array
for ((i=1; i<$nlines; i++)); do
  column_3[$i]=$((column_2[$i] - column_1[$i]))
done
echo "${column_3[@]}"

# 5. Create a new CSV file with the new column added.
# Write the new array to file line-by-line.
# Intitialize the file with a header.
# Use redirection and recall how to merge two files side-by-side.
# Ensure your final report has the correct CSV format.
## Combine the new array with the csv file
# first write the new array to file
# initialize the file with a header
echo "${column_3[0]}" > column_3.txt
for ((i=1; i<nlines; i++)); do
  echo "${column_3[$i]}" >> column_3.txt
done
paste -d "," $csv_file column_3.txt > report.csv
