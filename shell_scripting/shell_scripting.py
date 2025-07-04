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
