### Creating a shell script file and adding content

# create a shell script file
touch shell_scripting/hello_world.sh

# add #! /bin/bash to file using command line
echo '#! /bin/bash' >> hello_world.sh

# add text 'echo hello world' to hello_world.sh
echo 'echo hello world' >> hello_world.sh

# Note: make sure you are at the folder with the files

### Run shell script file by making it executable (needs x permission to be executable)

# Check permissions of the file
ls -l shell_scripting/hello_world.sh

# make file excecutable to all users and groups
chmod +x hello_world.sh

# Execute script (should print 'hello world') in command line
./hello_world.sh

# Shell variables offer a powerful way to store and later access or modify information such as numbers, character strings, and other data structures by name.
$ firstname=Jeff
$ echo $firstname
Jeff

# The first line assigns the value Jeff to a new variable called firstname.
# The next line accesses and displays the value of the variable, using the echo command
# along with the special character $ in front of the variable name to extract its value,
# which is the string

# Another way to create a shell variable using read command
$ read lastname
# on the command line, the shell waits for you to enter some text:
$ read lastname
Grossman
# Now we can see that the value Grossman has just been stored in the variable lastname by the read command:
$ read lastname
Grossman
$ echo $lastname
Grossman

# you can echo the values of multiple variables at once.
echo $firstname $lastname

# As you will soon see, the read command is particularly useful in shell scripting. Y
# You can use it within a shell script to prompt users to input information,
# which is then stored in a shell variable and available for use by the shell script while it is running.
# You will also learn about command line arguments, which are values that can be passed to a script and
# automatically assigned to shell variables.
