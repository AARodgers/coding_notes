#!/bin/bash

# Task 1: Set variables from command line arguments
targetDirectory=$1
destinationDirectory=$2

# ---

# Task 2: Display the values of the two variables
echo "Target Directory: $targetDirectory"
echo "Destination Directory: $destinationDirectory"

# ---

# Task 3: Define currentTS as the current timestamp in seconds
currentTS=$(date +%s)

# ---

# Task 4: Define backupFileName
backupFileName="backup-$currentTS.tar.gz"

# ---

# Task 5: Define origAbsPath with the absolute path of the current directory
origAbsPath=$(pwd)

# ---

# Task 6: Define destAbsPath and validate the directory
cd "$destinationDirectory" || exit # Change to the destination directory, or exit if it fails
destAbsPath=$(pwd)             # Get its absolute path

# (Optional: Change back to the original directory for subsequent tasks)
# cd "$origAbsPath"


=====================================================================
# 1. Create the directories
mkdir target_directory_name
mkdir destination_directory_name

# 2. Add a dummy file to the target (optional, but good for testing later)
touch target_directory_name/testfile.txt

# 3. Run the script using the names you just created
./backup.sh target_directory_name destination_directory_name

=========

Task 16
Download the following .zip file with the wget command:
1
wget https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-LX0117EN-SkillsNetwork/labs/Final%20Project/important-documents.zip

Copied!

Wrap Toggled!
Unzip the archive file:
1
unzip -DDo important-documents.zip

Copied!

Wrap Toggled!
Note: -DDo overwrites without restoring original modified date.

Update the file’s last-modified date to now:
1
touch important-documents/*

Copied!

Wrap Toggled!
Test your script using the following command:
1
./backup.sh important-documents .

Copied!

Wrap Toggled!
This should have created a file called backup-[CURRENT_TIMESTAMP].tar.gz in your current directory.

Take a screenshot of the output of ls -l and save it as 16-backup-complete.jpg or .png.
