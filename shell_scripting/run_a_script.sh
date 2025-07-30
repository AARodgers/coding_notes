#!/bin/bash
a=1
b=2
if [ $a -le $b ]
then
   echo "a is less than or equal to b"
else
   echo "a is not less than or equal to b"
fi

# TO RUN THIS SCRIPT:
# 1. Save this code in a file named run_a_script.sh
# 2. Open a terminal and navigate to the directory where the file is saved.
# 3. Make the script executable by running: chmod +x run_a_script.sh
# 4. Execute the script by running: ./run_a_script.sh
