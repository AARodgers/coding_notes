#!/bin/bash

# This checks if the number of arguments is correct
# If the number of arguments is incorrect ( $# != 2) print error message and exit
if [[ $# != 2 ]]
then
  echo "backup.sh target_directory_name destination_directory_name"
  exit
fi

# This checks if argument 1 and argument 2 are valid directory paths
if [[ ! -d $1 ]] || [[ ! -d $2 ]]
then
  echo "Invalid directory path provided"
  exit
fi

# [TASK 1]
targetDirectory=$1
destinationDirectory=$2

# [TASK 2]
echo "Backing up: $targetDirectory"
echo "To: $destinationDirectory"

# [TASK 3]
currentTS=$(date +%s)

# [TASK 4]
backupFileName="backup-[$currentTS].tar.gz"

# We're going to:
  # 1: Go into the target directory
  # 2: Create the backup file
  # 3: Move the backup file to the destination directory

# To make things easier, we will define some useful variables...

# [TASK 5]
origAbsPath=$(pwd)

# [TASK 6]
# destDirAbsPath=$(cd "$destinationDirectory" && pwd) OR
cd "$destinationDirectory" || exit # Change to the destination directory, or exit if it fails
destAbsPath=$(pwd)             # Get its absolute path

# [TASK 7]
cd "$origAbsPath"
cd "$targetDirectory"

# [TASK 8]
yesterdayTS=$((currentTS - 24 * 60 * 60))

# This declares an array named toBackup
# Append to array with: myArray+=($myVariable)
declare -a toBackup
# When you print or echo an array, you will see its string representation,
# which is simply all of its values separated by spaces
# $ declare -a myArray
# $ myArray+=("Linux")
# $ myArray+=("is")
# $ myArray+=("cool!")
# $ echo ${myArray[@]}
# Linux is cool!
# This will be useful later in the script where you will pass the array $toBackup, consisting
# of the names of all files that need to be backed up, to the tar command. This will archive all files at once!


for file in *  # Loop over all files in the target directory
do
  if [[ $(date -r "$file" +%s) -gt $yesterdayTS ]]
  then
    toBackup+=($file)
  fi
done

# [TASK 12]
#After the for loop, compress and archive the files,
# using the $toBackup array of filenames, to a file with the name backupFileName
tar -czvf $backupFileName ${toBackup[@]}

# [TASK 13]
mv "$backupFileName" "$destAbsPath"

# Congratulations! You completed the final project for this course!
