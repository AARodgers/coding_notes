permissions.py

# There are three possible levels of file ownership in Linux: user, group, and other.
# Whoever creates a file, namely the user at the time of creation, becomes the owner of that file by default. A group of users can also share ownership of a file. The other
# category essentially refers to anyone in the universe with access to your Linux machine
$ echo "Who can read this file?" > my_new_file
$ more my_new_file
Who can read this file?
$ ls -l my_new_file
-rw-r--r-- 1 theia users 25 Dec 22 17:47 x

Here we've echoed the string "Who can read this file?" into a new file called my_new_file. The next line uses the more command to print the contents of the new file. Finally, '
the ls command with the -l option displays the file's (default) permissions: rw-r--r--

The first three characters (rw-) define the user permissions, the next three (r--)
the group permissions, and the final three (r--) the other permissions.

So you, being the user, have the permission rw-, which means you have read and
write permissions by default, but do not have execution permissions. Otherwise,
there would be an x in place of the last -.

Thus by looking at the entire line, rw-r--r--, you can see that anyone can read the file,
nobody can execute it, and you are the only user that can write to it.

Note: The - at the very beginning of the line in the terminal means that the
permissions are referring to a file. If you were getting the permissions to a directory,
you would see a d in the front for "directory".

Directory permissions
The permissions for directories are similar but distinct for files. Though directories use the same rwx format, the symbols have slightly different meanings.

The following table illustrates the meanings of each permission for directories:

Directory Permission	Permissible action(s)
r	List directory contents using ls command
w	Add or remove files or directories
x	Enter directory using cd command

You can revoke read permissions from your group and all other users by using the
chmod command. Ensure successful modification by using the ls -l command again:

chmod go-r my_new_file
ls -l my_new_file
-rw------- 1 theia users 24 Dec 22 18:49 my_new_file

In the chmod command, go-r is the permission change to be applied, which in this
case means removing for the group (g) and others (o) the read (r) permission.
The chmod command can be used with both files and directories.

Executable files

A Linux file is executable if it contains instructions that can be directly
interpreted by the operating system. Basically, an executable file is a
ready-to-run program. They're also referred to as binaries or executables.

Formally speaking, for a text file to be considered an executable shell script for a given user, it needs to have two things:

Execute permissions set for that user
A directive, called a "shebang", in its first line to declare itself to the operating
system as a binary

# To see the permissions currently set for a file, run the ls command with the -l option.

# For example, to see the permissions for the file named usdoi.txt in your current directory,
# enter the following:
$ ls -l usdoi.txt
# The output will look something like this:
# -rwxr-xr-x 1 theia users 25 Dec 22 17:47 usdoi.txt

# The first character in the output indicates the type of file. The next three characters indicate the permissions for the user (the owner of the file), the next three
# characters indicate the permissions for the group, and the last three characters indicate the permissions for others. The "r" indicates read permission, "w" indicates write
The first three entries correspond to the current user, the next three correspond to
the group, and the last three are for all others. You can see the user has read and
write permissions, while the user group only has read permission, and all other users
have only read permission. No users have execute permission, as indicated by the -
instead of an x in the third position for each user category.

Change file access permissions
The chmod or change mode command lets you change the permissions set for a file.

Specify which permissions to change with a combination of the following characters:

Option	Description
r, w, x	Permissions: read, write, and execute
u,g, o 	User categories: user, group, and all others
+, -	Operations: grant and revoke

The following command revokes read permissions for all users (user, group, and other)
on the file usdoi.txt:
chmod -r usdoi.txt

You can verify the changed permissions by entering:

$ ls -l usdoi.txt

To grant read access to all users on usdoi.txt, enter:

chmod +r usdoi.txt

Verify the changed permissions again with the following:

ls -l usdoi.txt

Now to remove the read permission only for 'other' category, enter the following:

chmod o-r usdoi.txt

Verify the changed permissions as follows:

ls -l usdoi.txt

total 12
drwxr-sr-x 2 theia users 4096 May 15 14:06 test
-rw-r----- 1 theia users 8121 Sep 28  2022 usdoi.txt
You, "theia", as the owner of test, have read, write, and execute permissions set by
default. But all others only have read and execute permissions set and cannot write
to your test directory. This means users outside your group can't add or remove files
from test.
They can, however, explore your directory to see what files and directories exist there.

Note: You might be wondering what that s permission is in the execute slot for your group. The s stands for "special permission". It means that any new files created within the directory will have their group ownership set to be the same as the directory owner. We won't go into this level of detail in this course, but you can learn more about advanced Linux permissions here: Linux permissions: SUID, SGID, and sticky bit.

2.2 Remove user execute permissions on your test directory
Remove your user execute permissions on test using the following command:

1
chmod u-x test

Copied!
Now, what happens when you try to change directories to test?

1
cd test

Copied!
You get an error message!

bash: cd: test: Permission denied

As you just removed execute permissions for yourself on your test directory, you can no longer make
it your present working directory. However, you can still "read" it with the ls command:

Even though you have "write" permissions set, you can't actually create a new
directory within test, because removing execute permissions overrides write permissions.
For example, entering,

mkdir test/test3

throws an error:

mkdir: cannot create directory ‘test/test’: Permission denied

This time, try restoring execute permissions on test and denying write permissions.
Then verify your changes:

chmod u+x test
chmod u-w test
ls -l


Now you can go into test, but you still can't write to it! Entering

cd test
mkdir test_again

hrows the error:

mkdir: cannot create directory ‘test_again’: Permission denied


