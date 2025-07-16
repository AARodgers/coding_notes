# Filters are shell commands that read from standard input (usually key board) and write to standard output
# usually the terminal. They transform input data into output data.

# Filters can be chained together using pipes (|) so that the output of one filter becomes the input of the next filter.
# Example: ls -l | grep ".sh" | sort

# list the first 4 shell variables
set | head -4

# Define a shell variable calld GREETINGS with value "Hello World"
GREETINGS="Hello World"
# Print the value of the variable GREETINGS
echo $GREETINGS
# Define anothr variable called GREETINGS2 with value "Hello World2"
GREETINGS2="Hello World2"
# Print the value of the variable GRETINGS GREETINGS2
echo $GREETINGS $GREETINGS2

# Delete the variable GREETINGS2
unset GREETINGS2

# Environment variables are shell variables that are available to all child processes of the shell. Have extended scope.
# To make a shell variable an environment variable, use the export command.
# Example: export VAR_NAME=VAR_VALUE

# list all environment variables
env

# See if GREETINGS is an environment variable by filtering output with pattern "GREE"
env | grep GREE

# Sort lines of text file by alpahabetical order and only show unique lines ( uniq only works on sorted input or consecutive duplicates)
echo -e "banana\napple\norange\nbanana" | sort | uniq

# tr ( translate) replaces character in input text but only accepts standard input (usually keyboard) BUT NOT strings or filenames
# Example: echo "hello world" | tr "h" "H"
echo "hello world" | tr "h" "H"
