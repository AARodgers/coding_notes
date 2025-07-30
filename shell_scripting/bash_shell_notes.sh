# for commenting
; - separate commands typed on same line
# Example: will return commands on two lines
echo "hello world"; whoami
* is filename expansion wildcard
# example: ls /bin/ba* will return all files in /bin starting with ba
#output: bash
? is single character wildcard
# example: ls /bin/b??h will return all files in /bin starting with b and ending with h with two characters in between
#output: bash, bsh, bzh
# Use backslash \ to escape special characters
\ - escape special characters
# Example: echo "hello\*world" will print hello*world instead of expanding the
# example: echo "\$1 each" will print $1 each instead of expanding $1 to the first argument passed to the script
" " - will interpret everything literally except $, `, \ and ! (metacharacters still keep their meaning_)
' ' - will interpret everything literally except \ (only when followed by another single quote or back
# example: echo "$1 each" will return 'each' because it thinks $1 is an empty variable
# example: '$1 each' will return $1 each literally, same as "\$1 each"
` ` - command substitution, runs the command inside and returns the output


I/O redirection:
> - redirect standard output to a file, overwriting the file if it exists
>> - ( avoids overwriting output to file)redirect standard output to a file, appending to the file if it exists ()
2> - redirect standard error to a file, overwriting the file if it exists
2>> - redirect standard error to a file, appending to the file if it exists
< - redirect file contents to standard input from a file
# Example:
# create a file and put line 1 on in it, see what's in it and add more lines
echo "line 1" > myfile.txt


# redirect standard erro to an error file
# example: if type garbage in terminal, it will return an error, put that error in an error_file.txt
garbage 2> error_file.txt
cat error_file.txt


# COMMAND SUBSTITUTION ( 2 ways: $(command) or `command` )
# Example: assign the output of a command to a variable using backticks ` `
DATE=`date`
# Example:
# store current directory path in a variable called here
here=$(pwd)
echo "The current directory is $here"
# then echo ( or print) it's value in directory
echo $here

# COMMAND LINE ARGUMENTS
# a way to pass arguments to a script when executing it

# BATCH MODE VERSUS CONCURRENT MODE
# Batch mode runs sequentially, one command at a time in order
# example: command1; command2 ( command2 will only run after command1 completes)
# Command Mode runs in parallel, multiple commands at the same time
# example: command1 & command2 ( command1 and command2 will run at the same
 # command1 runs in the background and then passes command to command2
 
