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

# Use backslash \ to escape special characters such as space, tab and $ (preserves their literal meaning)
\ - escape special characters and spaces
# Example: echo "hello\ world" will print hello world instead of interpreting the space as a command separator
# Example: echo "hello\*world" will print hello*world instead of expanding the
# example: echo "\$1 each" will print $1 each instead of expanding $1 to the first argument passed to the script

" " - will interpret everything literally except $, `, \ and ! (metacharacters still keep their meaning_)
' ' - will interpret everything literally except \ (only when followed by another single quote or back
# example: echo "$1 each" will return 'each' because it thinks $1 is an empty variable
# example: '$1 each' will return $1 each literally, same as "\$1 each"
` ` - command substitution, runs the command inside and returns the output


I/O redirection:
Input/output (IO) redirection is the process of directing the flow of data between a program and its input/output sources.
By default, a program reads input from standard input, the keyboard, and writes output to standard output, the terminal.
However, using IO redirection, you can redirect a program's input or output to or from a file or another program.
> - redirect standard output to a file, overwriting the file if it exists
>> - ( avoids overwriting output to file)redirect standard output to a file, appending to the file if it exists ()
2> - redirect standard error to a file, overwriting the file if it exists
2>> - redirect standard error to a file, appending to the file if it exists
< - redirect file contents to standard input from a file
# Example:
# create a file and put line 1 on in it, see what's in it and add more lines
echo "line 1" > myfile.txt

# REDIRECT OUTPUT BY OVERWRITING A FILE
# redirect standard erro to an error file
# example: if type garbage in terminal, it will return an error, put that error in an error_file.txt
garbage 2> error_file.txt
cat error_file.txt
# Example 2:
ls > files.txt will create a file called files.txt if it doesn't exist, and write the output of the ls command to it.

# REDIRECT OUTPUT BY APPENDING TO A FILE
# example:
ls >> files.txt will append the output of the ls command to the files.txt file if it exists or will create it it if not

# REDIRECT STANDARD ERROR OUTPUT (2>)
# used to redirect standard error output of a command to a file
# example:
ls non-existent-file 2> error_file.txt
# This will redirect the error message to error_file.txt instead of displaying it on the terminal. Will overwrite if it exists

# APPEND STANDARD ERROR OUTPUT (2>>)
# used to append standard error output of a command to a file
# example:
ls non-existent-file 2>> error_file.txt

# REDIRECT INPUT FROM A FILE (<)
# used to redirect the standard input of a command from a file or another command
# example:
sort < myfile.txt
# This will read the contents of myfile.txt and sort them, displaying the sorted output on the terminal.

# COMMAND SUBSTITUTION ( 2 ways: $(command) or `command` )
# allows you to capture the output of a command and use it as an argument in another command
# denoted by backticks `command` or $(command)
# when the command is executed, the output replaces the command itself
# good for automating tasks and using the output of one command as input to another


# Example: assign the output of a command to a variable using backticks ` `
DATE=`date`
# Example:
# store current directory path in a variable called here
here=$(pwd)
echo "The current directory is $here"
# then echo ( or print) it's value in directory
echo $here

# example 2:
# you could store the path to your current directory in a variable by applying command substitution on the pwd command, then move to another
# directory, and finally return to your original directory by invoking the cd command on the variable you stored, as follows:
$ here=$(pwd)
$ cd path_to_some_other_directory
$ cd $here

# COMMAND LINE ARGUMENTS
# a way to pass arguments to a script when executing it

# BATCH MODE VERSUS CONCURRENT MODE
# Batch mode runs sequentially, one command at a time in order
# example: command1; command2 ( command2 will only run after command1 completes)
# Command Mode runs in parallel, multiple commands at the same time
# example: command1 & command2 ( command1 and command2 will run at the same
 # command1 runs in the background and then passes command to command2
