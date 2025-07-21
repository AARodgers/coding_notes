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
