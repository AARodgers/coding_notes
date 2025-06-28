Directory	Contains
/bin	System commands, also called binaries
/sbin	System administration binaries
/usr	User programs and data
/home	Home directory
/media	Removable media device directories

Symbol	Stands for path to
~	Home directory
/	Root directory
.	Current directory
..	Parent directory

Go to home directory:
cd ~

Change to parent directory:
cd ..

Change to root directory;
cd /

Change to a subdirectory:
cd <name_of_subdirectory>

Change directories:
cd ./bin
(the . period means the path to your current working directory)
(if you are already in bin, it will try to take you to /bin/bin)

Change to a sibling directory that is at the same level in the current directory:
cd ../<directory_name>

NANO
Open text editor nano:
nano file_name

Navigate using page up and down, home and end keys, and arrows

Find text:
Ctrl + W, then type in text

VIM
to open;
vim   OR  vim <file_name>

Vim has 2 modes:
1. Command mode - For navigation and commands
2. Insert mode - For inserting text

Switch to insert mode:
Press `i` in command mode

Switch back to command mode:
Press `Esc` in insert mode

Save and exit:
In command mode, type `:wq` and press `Enter`
or
:sav file_name

Exit without saving:
In command mode, type `:q!` and press `Enter`

:w to write the buffer to file without exiting
:q to quit vim session
:q! to exit without saving

DEBIAN or .deb files/packages are used for Debian based distributions ('distros'),
like Debian , Ubuntu, and Linux Mint.

RPM (Red Hat Package Manager) or .rpm files/packages are used for Red Hat based distributions,
like Red Hat Enterprise Linux (RHEL), CentOS, and Fedora.

If you want to change the format from one to another:
RPM to DEB:
alien -k <file_name>.rpm
DEB to RPM:
alien -r <file_name>.deb

sudo apt update
- to install all current updates
- to find available packages for your distro

sudo apt package_name
- to install a package

YUM (Yellowdog Updater, Modified) is a package manager used for Red Hat based distributions.

To install a package:
sudo yum install <package_name>

To update all packages:
sudo yum update

To remove a package:
sudo yum remove <package_name>

To search for a package:
yum search <package_name>

# Print path to default shell
printevn SHELL
# get username
whoami
# get user id and group id
id
# get user name and id
uid
# get group name and id
gid
# get operating system name
uname
# print all system info
uname -a
# get running processes
ps
#get resource usage
top
# get mounted file systems
df
# reference manual ( linux commands)
man
# today's date
date
# copy file
cp
# move file name and path
mv
# remove file
rm
# make empty file, update time stamp
touch
# change/modify file permissions
chmod
# get count of lines, words, characters
wc
# return lines in file with matching pattern
grep
# list files and directories
ls
# find files in a directory tree
find
# get present working directory
pwd
# make a directory
mkdir
# change directory
cd
# remove directory
rm
# print file content
cat
# print file contents page by page
more
# print first N lines of file
head
# print last N lines of file
tail
# print string or variable values
echo
# archive a set of files
tar
# compress a set of files
zip
# unzip a set of files, extract files from a compressed archive
unzip
# print hostname
hostname
# send packets to URL and print reponse
ping
# display or configure system network interfaces
ifconfig
# display contents of file at a url
curl
# download file from url
wget

# Informational Commands
# prints user number
id -u
id -u -n # user id and name
# kernel name/operating system name and version number
uname # unixname
uname -s -r # gives operating name and verison
uname -v # get more info about operating system
# show disk usage
df
df -h ~ # can check space on home directory
df -h #disk usage on all filesystems
# Monitor processes (process status)
ps
ps -e # shows all processes running on a system regardless of who started them
top # table of processes - can act as task manager
top -n 3 # show top three running task
# Printing strings and variables
echo # just prints a new line in temrinal
echo Hello # will print Hello
echo $variable_name # prints the value of a variable
echo $PATH #prints the value of the PATH variable
# Returning the data
date # returns default date format
date "+%j day of %Y" # prints numerical day of year and year

# Display Linux manual
man
man id # will display manual for id command

# You can get a listing of all the commands on your system that have a manual page by entering:
man -k .

#To see the man page for a command, simply enter:
man command_name
man -help

# You can install a command-line tool to access TLDR Pages from your terminal. Install it using the following command:
# tdlr means too long didn't read
# easier to read than man pages
npm install -g tldr
# Once you've installed the tool, you can use the tldr command to easily access the TLDR page of a command.
tldr command_name


#Wikipedia maintains a list of commands that can be found on Unix operating systems, along with a short description. You can check the page to quickly reference a Unix command: https://en.wikipedia.org/wiki/List_of_Unix_commands
https://en.wikipedia.org/wiki/List_of_Unix_commands

# display available disk space
df
# get available disk space in a "human-readable" format, enter:
df -h

#  lists each process that is currently running and its PID (process id).
# output only contains the processes that are owned by you.
ps
# By using the -e option, you can display all of the processes running on the system.
ps -e

# Get information on the running processes and system resources
# will give you  PID, user, CPU, memory, and command
# shows information like system uptime, number of users, load average, and overall memory usage
top

# the output keeps refreshing until you press q or Ctrl + c.

# If you want to exit automatically after a specified number of repetitions, use the -n option as follows:
top -n 10

# You can press the following keys with Shift while top is running to sort the table:

Key	Sorts by ( will sort in ascending order)
m	Memory Usage
p	CPU Usage
n	Process ID (PID)
t	Running Time

# echo command displays the given text on the screen.
echo "Welcome to the linux lab"
prints
Welcome to the linux lab.

\n	Start a new line
\t	Insert a tab

echo -e "This will be printed \nin two lines"

# date command displays the current date and time.
date

# following command displays the current date in mm/dd/yy format:
date "+%D"

Specifier	Explanation
%d	Displays the day of the month (01 to 31)
%h	Displays the abbreviated month name (Jan to Dec)
%m	Displays the month of year (01 to 12)
%Y	Displays the four-digit year
%T	Displays the time in 24 hour format as HH:MM:SS
%H	Displays the hour

# The man command displays the user manual for any command that you provide as its argument.
man ls

# To see all available man pages with a brief description of each command, enter:
man -k .
# *** This gives you git commits too.

ls -l # long listing format
ls -a # show all files including hidden files
ls -lh # human readable format
ls -R # recursive listing
ls -t # sort by time
ls -S # sort by size

ls Downloads # list files in Downloads directory

find . -name "*.txt" # find all text files in current directory
find . -name "a.txt" # find file named a.txt in current directory
find . -type f -name "*.txt" # find all text files in current directory
(. means current directory, -type f means file, -type d means directory)
find . iname "*.txt" # find all text files in current directory, case insensitive

rm file.py # remove file.py
rm -r directory_name # remove directory and its contents
rm -rf directory_name # remove directory and its contents without confirmation
rmdir directory_name # remove empty directory

touch file.txt # create empty file.txt

date -r notes.txt # get last modified date of file.txt

cp /source/file /destination/file # copy file from source to destination
cp /source/file /desination # copy file from source to destination
cp -r /source/directory /destination/directory # copy directory from source to destination

mv /source/file /destination/dir # move file from source to destination
mv /source/dir /destination/dir # move directory from source to destination

chmod 755 file.txt # change file permissions to rwxr-xr-x
chmod +x file.txt # add execute permission to file.txt
chmod -x file.txt # remove execute permission from file.txt
chmod 644 file.txt # change file permissions to rw-r--r--

Example:
ls -l my_script.sh # check file permissions
output: rw r--r my_script.sh #  read and write permissions for user, read permission for group and others
chmod +x my_script.sh # add execute permission to my_script.sh
ls -l my_script.sh # check file permissions (x means execute permission)
output: rwxr-xr-x my_script.sh # read, write and execute permissions for user, read and execute permissions for group and others

nohup command_name & # run command in background and ignore hangup signal
To include the dependencies listed in someone else's `requirements.txt` file into your current **conda environment**, you can use the following steps:

---

### **Steps to Install Dependencies from `requirements.txt` in a Conda Environment**

#### 1. **Activate Your Conda Environment**
   - Ensure you are already in the correct conda environment. If not, activate it:
     ```bash
     conda activate your_environment_name
     ```

#### 2. **Install Dependencies Using `pip`**
   - Even though you're in a conda environment, you can use `pip` (which is compatible with conda environments) to install the packages from the `requirements.txt` file:
     ```bash
     pip install -r path/to/requirements.txt
     ```
   - Replace `path/to/requirements.txt` with the actual path to the file.

#### 3. **Verify Installation**
   - After installation, you can check that the packages are installed by running:
     ```bash
     pip list
     ```
   - This will display all installed packages and their versions.

---

### **Notes and Best Practices**
1. **Ensure `pip` is Installed in Your Conda Environment**:
   - If `pip` is not already installed in your conda environment, you can add it with:
     ```bash
     conda install pip
     ```

2. **Resolve Potential Conflicts**:
   - If the `requirements.txt` file contains packages that conflict with conda-installed dependencies, you may encounter issues. To avoid this:
     - Use `conda install` for packages that are available in conda's repositories.
     - Use `pip` only for packages not available in conda.

3. **Check for Conda-Available Packages First** (Optional):
   - If you want to prioritize using conda packages, you can manually install the packages listed in `requirements.txt` via conda:
     ```bash
     conda install package_name
     ```
   - You may need to edit the `requirements.txt` file to remove version-specific constraints or unsupported packages.

4. **Create a Backup of Your Environment**:
   - Before making changes, you can export your current environment in case you need to revert:
     ```bash
     conda env export > environment_backup.yml
     ```

---

### **Advanced: Convert `requirements.txt` to Conda-Compatible Format**
If you want to ensure compatibility with conda, you can convert the `requirements.txt` file into a `conda` environment YAML file:
1. Use the following command to generate a new YAML file:
   ```bash
   pip install pipreqs
   pipreqs /path/to/project --savepath environment.yml
   ```
2. Edit the `environment.yml` file as needed, then recreate the environment:
   ```bash
   conda env create -f environment.yml
   ```

---

nohup command_name & # run command in background and ignore hangup signal
# find pid
ps aux | grep name_of_script_or_program
# Once you have the PID, stop the process using the kill command:
kill PID
# If the process doesn’t stop, use the -9 option to forcefully terminate it:
kill -9 PID
# check if the process is still running
ps aux | grep name_of_script_or_program

# If you want to stop all processes running with nohup, you can find and terminate them in bulk:
# List All nohup Processes:
ps aux | grep nohup
# Kill All Matching Processes:
ps aux | grep nohup | awk '{print $2}' | xargs kill
# Add -9 to forcefully kill them if needed:
ps aux | grep nohup | awk '{print $2}' | xargs kill -9
# nohup.out File: If you no longer need the output log created by nohup, you can delete it:
rm nohup.out

# if Ctrl + C doesn't work, you can use:
# 1. Open a new terminal tab or window.
# 2. Navigate to the same directory and confirm the status of your repository:
git status
# 3. If the terminal remains stuck:
# - **Mac**: Press **Command + Option + Esc**, select your terminal application, and force quit it.

# command to tell you the full path of a file or folder:
To find the **full path** to a specific file or folder in the bash command line, you can use the following commands:

---

### **1. Use the `realpath` Command**
The `realpath` command outputs the absolute (full) path of a file or folder.

#### Syntax:
```bash
realpath path/to/file_or_folder
```

#### Example:
```bash
realpath myfile.txt
```

**Output**:
```
/home/username/myfile.txt
```

---

### **2. Use the `readlink` Command**
If `realpath` is not available, you can use `readlink -f` (works similarly).

#### Syntax:
```bash
readlink -f path/to/file_or_folder
```

#### Example:
```bash
readlink -f myfolder
```

**Output**:
```
/home/username/myfolder
```

---

### **3. Use the `pwd` Command**
If you're already in the directory containing the file or folder, you can combine `pwd` (print working directory) with the relative path.

#### Syntax:
```bash
pwd
```

#### Example:
```bash
pwd
```
If you're in `/home/username`, and the file is `myfile.txt` in the current directory:
```bash
echo "$(pwd)/myfile.txt"
```

**Output**:
```
/home/username/myfile.txt
```

---

### **4. Use the `find` Command**
If you're not sure where the file or folder is located, you can search for it and display the full path.

#### Syntax:
```bash
find / -name "file_or_folder_name"
```

#### Example:
```bash
find / -name "myfile.txt"
```

**Output**:
```
/home/username/documents/myfile.txt
```

- The `/` starts the search from the root directory. You can replace `/` with a specific directory to narrow the search.

---

### **5. Drag and Drop in Terminal (Mac/Linux GUI)**
If you're using a graphical interface, you can drag and drop the file or folder into the terminal, and it will display the full path.

---

### **6. Use `ls` with Absolute Paths**
If the file is in a known directory, you can use `ls` to display its full path.

#### Syntax:
```bash
ls -d $PWD/path/to/file_or_folder
```

#### Example:
```bash
ls -d $PWD/myfile.txt
```

**Output**:
```
/home/username/myfile.txt
```

---

### **Summary of Commands**
| Command                   | Purpose                              |
|---------------------------|--------------------------------------|
| `realpath file_or_folder` | Get the full path of a file/folder   |
| `readlink -f file_or_folder` | Get the absolute path (alternative) |
| `pwd`                     | Print the current working directory |
| `find / -name "name"`     | Search for a file and get its path  |
| `ls -d $PWD/path`         | Combine `ls` and `pwd` for the path |

---
# to find the absolute and relative path of a file or directory in Linux, you can use the following commands:
# 1. **Absolute Path**: Use the `realpath` command or `readlink -f`.
To correctly construct the path to the `fake_data` folder inside your current `splink` directory, you need to use the **absolute path** or **relative path** based on your current location in the terminal. Here's how you can determine the correct path:

---

### **1. Determine the Absolute Path**
The **absolute path** is the full path to the `fake_data` folder from the root of your filesystem.

#### Steps to Find the Absolute Path:
1. **Use `pwd`**:
   - If you're currently inside the `splink` folder, run:
     ```bash
     pwd
     ```
   - This will output the full path to the `splink` folder, such as:
     ```
     /home/username/splink
     ```

2. **Append `fake_data`**:
   - Combine the output of `pwd` with `fake_data`:
     ```bash
     /home/username/splink/fake_data
     ```

#### Example Command:
To move the file to the `fake_data` folder:
```bash
mv ~/path/to/data /home/username/splink/fake_data
```

---

### **2. Use the Relative Path**
If you're already inside the `splink` folder, you can use the **relative path** to refer to the `fake_data` folder.

#### Steps to Use Relative Path:
1. **Ensure You're in the `splink` Folder**:
   - Run:
     ```bash
     pwd
     ```
   - If the output is `/home/username/splink`, you're in the right folder.

2. **Use the Relative Path**:
   - Since `fake_data` is a subfolder of `splink`, you can refer to it directly:
     ```bash
     mv ~/path/to/data fake_data/
     ```

---

### **3. Verify the Paths**
If you're unsure of the source or target paths, verify them:

#### Verify the Source File:
Run:
```bash
ls ~/path/to/data
```
- This ensures the file or folder you want to move exists.

#### Verify the Target Directory:
Run:
```bash
ls /home/username/splink/fake_data
```
- This ensures the `fake_data` folder exists.

---

### **4. Example Workflow**
Here’s a complete workflow to move the file:

#### Step 1: Verify Your Current Location
Run:
```bash
pwd
```
- If you're already in `/home/username/splink`, you can use:
  ```bash
  mv ~/path/to/data fake_data/
  ```

#### Step 2: Use Absolute Path (if not in `splink`)
If you're not in the `splink` folder, use:
```bash
mv ~/path/to/data /home/username/splink/fake_data
```

---

### **5. Common Issues**
1. **File or Folder Doesn't Exist**:
   - If `mv` says "No such file or directory," verify both the source (`~/path/to/data`) and target (`/home/username/splink/fake_data`) paths using `ls`.

2. **Permission Issues**:
   - If you encounter permission errors, use `sudo`:
     ```bash
     sudo mv ~/path/to/data /home/username/splink/fake_data
     ```

3. **Misunderstood `~`**:
   - The `~` symbol refers to your home directory (e.g., `/home/username`). Ensure the source path starts with `~/`.

---

#####################################


# how to erase a directory
# To erase a directory in Linux, you can use the `rm` command with the `-r` (recursive) option. This allows you to remove a directory and all of its contents, including subdirectories and files.
#
# **Command to Erase a Directory**:
```bash
rm -r directory_name
```
# Replace `directory_name` with the name of the directory you want to erase.

# recursively list files in a directory
ls -r

# to archive a directory and all subdirectories and files, you can use the `tar` command:
tar -cf notes.tar notes
# the c option stands for "create" and the f option specifies the filename of the archive.
#  This command creates an archive file named `notes.tar` containing the `notes` directory and all its contents.
# To extract the contents of the archive, you can use:
tar -xf notes.tar
