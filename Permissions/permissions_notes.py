$ echo "Who can read this file?" > my_new_file
# The 'more' command in Linux is used to view the contents of a file in a page-by-page manner
$ more my_new_file
Who can read this file?
$ ls -l my_new_file
-rw-r--r-- 1 theia users 25 Dec 22 17:47 x

Each file and each directory in your Linux system has permissions set for three permission categories: the 'user', the 'group', and 'all users' (or 'other').

The following permissions are set for each file and directory:

Permission	Symbol
read	r
write	w
execute	x
To see the permissions currently set for a file, run the ls command with the -l option.

For example, to see the permissions for the file named usdoi.txt in your current directory, enter the following:

1
$ ls -l usdoi.txt
-rw-r--r-- 1 theia users 25 Dec 22 17:47 usdoi.txt

A sample output looks like the following:

-rw-r--r-- 1 theia theia 8121 May 31 16:45 usdoi.txt

The permissions set here are rw-r--r--. The - preceeding these permissions indicates that usdoi.txt is a file. If it were a directory, you would see a d instead of the -.

The first three entries correspond to the current user, the next three correspond to the group, and the last three are for all others. You can see the user has read and write permissions, while the user group only has read permission, and all other users have only read permission. No users have execute permission,
as indicated by the - instead of an x in the third position for each user category.

Chomd ( change mode command, lets you change permissions)
# To change the permissions of a file, you can use the chmod command. The syntax is:
chmod [permissions] [file]
# For example, to give the user execute permission on the file named usdoi.txt, you would enter:
$ chmod u+x usdoi.txt

The following command revokes read permissions for all users (user, group, and other) on the file usdoi.txt:

$ chmod -r usdoi.txt

Directory Permission	Permissible action(s)
r	list directory contents using ls command
w	add/remove files or directories from directory
x	enter directory using cd command

mkdir test
ls -l # to see the permissions of the test directory
# The output will show the permissions for the test directory like this:
drwxr-sr-x 2 theia users 4096 Dec 22 17:47 test

Note: You might be wondering what that s permission is in the execute slot for your group. The s stands for "special permission". It means that any new files created within the directory will have their group ownership set to be the same as the directory owner. We won't go into this level of detail in this course, but you can learn more
about advanced Linux permissions here: Linux permissions: SUID, SGID, and sticky bit.

Even though you have "write" permissions set, you can't actually create a new directory within test, because removing execute permissions overrides write permissions. For example, entering,

mkdir test/test3

5. View the permissions of the newly created directory, tmp_dir.

ls -ld tmp_dir

#### Linux commands for text files

cat file_name.txt # to see contents of a file
more file_name.txt # to see contents of a file in a paginated manner ( use space bar to scroll down, q to quit)
less file_name.txt # to see contents of a file in a paginated manner, with the ability to scroll up and down

head file_name.txt # to see the first 10 lines of a file
head -n 5 file_name.txt # to see the first 5 lines of a file
tail file_name.txt # to see the last 10 lines of a file
tail -n 5 file_name.txt # to see the last 5 lines of a file

wc file_name.txt # to count the number of lines, words, and characters in a file
example output:
7 7  42 file_name.txt # means there are 7 lines, 7 words, and 42 characters in the file


