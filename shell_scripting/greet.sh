#! /bin/bash

# This script accepts the user\'s name and prints
# a message greeting the user

# Print the prompt message on screen
echo -n "Enter your name :"

# Wait for user to enter a name, and save the entered name into the variable \'name\'
read name

# Print the welcome message followed by the name
echo "Welcome $name"

# The following message should print on a single line. Hence the usage of \'-n\'
echo -n "Congratulations! You just created and ran your first shell script "
echo "using Bash on IBM Skills Network"


### To execute
# First check permissions on file: ls -l greet.sh
# As it has read permissions, you can run it with: bash greet.sh

## To edit script and make it executable add 'shebang' so that name of script can be used like a command, it
# also lets you specify the path to the interpreter of the script ( here it is bash)

# 1. Find path to interpreter: which bash ( helps you find out the path of the command bash)
# should see /bin/bash
# 2. Add the shebang line at the top of the script: #! /bin/bash
# 3. Add execute permission for user: chmod +x greet.sh
# Tip: Generally it's not a good idea to grant permissions to a script for all users, groups, and others. It's
# more appropriate to limit the execute permission to only the owner, or the user who created the file (you).
# 4. Check permissions again: ls -l greet.sh (should see it is executable for users, groups adn others)
# 5. Change permissions to only allow the owner to execute: chmod go-x greet.sh ( takes away execute
# from groups and others)
# 6. Execute the script: ./greet.sh ( The . here refers to the current directory.
# You are telling Linux to execute the script greet.sh and that it can be found in the current directory.)

