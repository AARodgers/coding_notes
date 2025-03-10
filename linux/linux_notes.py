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


