# Archiving and Compression Notes
# Archiving:
  # Archiving is the process of moving data that is no longer actively used to a separate storage system.
  # It is a collection of data files and directories stores as a single file.
  # Can be backup in case of loss or corruption.

# Compression:
  # Compression is the process of reducing the size of a file or data stream by
  # reducing redundancy.
  # It can preserve storage space, speed up data transfers and reduce bandwidth usage.

# recursively list files in a directory
ls -r

# to archive a directory and all subdirectories and files, you can use the `tar` command:
tar -cf notes.tar notes
# the -cf option stands for "create" and "file" respectively, and the `f` option specifies the filename of the archive.
# when you:
ls # you will see
notes notes.tar # the archived file `notes.tar` is created in the current directory.

# If you want the file to be compressed, you can use the `-z` option to create a gzip-compressed archive:
tar -czf notes.tar.gz notes
# This command creates a gzip-compressed archive file named `notes.tar.gz` containing the `notes` directory and all its contents.
# The `z` option stands for "gzip compression" and put the file through this compression program.
# To extract the contents of the archive, you can use:
# the .gz helps windows based programs to recognize the file as a compressed archive or file type.


# This command creates an archive file named `notes.tar` containing the `notes` directory and all its contents.
# To extract the contents of the archive, you can use:
tar -xf notes.tar


# check the contents of the archive to see what files are included:
tar -tf notes.tar
# you are calling tar on your "notes.tar ball"
# The `-t` option stands for "list" and shows the contents of the archive
# without extracting them.
# list all directories and files in tar ball.

# Extract your archived files ( notes.tar ):
tar -xf notes.tar notes
# notes is optional destination directory.
# -x extracts the files from the archive, and -f specifies the archive file to extract from.
# -xf stands for "extract" and "file" respectively.

# then call:
ls -R
# to verify that the files have been extracted successfully.

# To decompress and extract at same time:
tar -xzf notes.tar.gz notes

# zip vs. tar:
# zip compresses files and directories to an archive
# zip: compress -> bundle (compresses files prior to bundling them)
# tar with -z option: bundle -> compress (achieves compression by applying gzip on
# entire tar ball, but only after bundling it )

# to compress your notes directory into a zip file, you can use the `zip` command:
zip -r notes.zip notes
# The `-r` option stands for "recursive" and includes all files and subdirectories
# within the `notes` directory in the zip file.
# To extract the contents of the zip file and decompress them, you can use:
unzip notes.zip

# Summary:
# compression preserves storage space, speeds data transfers and reduces system load
# zip compresses files and folders prior to archiving them
# tar archives files and directories into a tarball that then it can compress them with commands
# unzip unpacks and decompresses a zipped archive
# tar decompresses and unpacks a tar.gz archive


#####################



1
Hands-on Lab: Archiving and Compressing Files

2
About Skills Network Cloud IDE

3
Exercise 1 - File and folder archiving and compression

4
Summary
Exercise 1 - File and folder archiving and compression
1.1. Create and manage file archives
tar

The tar command allows you to pack multiple files and directories into a single archive file.

#The following command creates an archive of the entire /bin directory and writes the archive to a single file named bin.tar.

The options used are as follows:

Option	Description
-c	Create new archive file
-v	Verbosely list files processed
-f	Archive file name

tar -cvf bin.tar /bin

#To see the list of files in the archive, use the -t option:
tar -tvf bin.tar

#To untar the archive or extract files from the archive, use the -x option:
tar -xvf bin.tar

#Use the ls command to verify that the folder bin is extracted.
ls -l

1.2. Package and compress archive files
zip

The zip command allows you to compress files.

#The following command creates a zip file named config.zip consisting of all the files with extension .conf in the /etc directory.
zip config.zip /etc/*.conf

The -r option can be used to zip an entire directory.
The -y flag to prevent symbolic links from being followed recursively:

The following command creates an archive of the /bin directory.

zip -ry bin.zip /bin

1.3. Extract, list, or test compressed files in a ZIP archive
unzip

The unzip command allows you to extract files.

# To list the files of the archive config.zip, enter the following:

unzip -l config.zip

# The following command extracts all the files in the archive bin.zip.

unzip -o bin.zip

We added the -o option to force overwrite in case you run the command more than once.

You should see a folder named bin created in your directory.
