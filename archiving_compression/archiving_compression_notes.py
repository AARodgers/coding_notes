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
