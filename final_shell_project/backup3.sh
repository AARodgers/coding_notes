#!/bin/bash

# /home/project/targetDirectory
# /home/project/destinationDirectory
# make executable: chmod +x backup3.sh
# run script with arguments:
# ./backup3.sh "/Users/amandarodgers/code/coding_notes/final_shell_project/targetDirectory" "/Users/amandarodgers/code/coding_notes/final_shell_project/destinationDirectory"


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

#  We're going to:
  # 1: Go into the target directory
  # 2: Create the backup file
  # 3: Move the backup file to the destination directory

#  To make things easier, we will define some useful variables...

# [TASK 5]
origAbsPath=$(pwd)

# [TASK 6]
cd "$destinationDirectory" || exit
destAbsPath=$(pwd)

# Just to check destination path is defined
echo "destination directory is: $destinationDirectory"

# [TASK 7]
cd "$origAbsPath"
cd "$targetDirectory"

# Just to check target path is defined
echo "target directory is: $targetDirectory"

# [TASK 8]
yesterdayTS=$((currentTS - 24 * 60 * 60))

declare -a toBackup

echo "Check toBackup array before loop:"
# add something to toBackup
toBackup+=("test_text")
# see if toBackup array exist and has above value
echo ${toBackup[@]}

for file in *
do
  if [[ $file_last_modified_date -gt $yesterdayTS ]]
  then
    toBackup+=($file)
  fi
done

# [TASK 12]
tar -czvf $backupFileName "${toBackup[@]}"

# [TASK 13]
mv "$backupFileName" "$destAbsPath"
