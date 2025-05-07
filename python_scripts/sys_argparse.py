# import sys

# def get_sum_of_num(num1,num2,num3):
#   return(int(num1)+int(num2)+int(num3))

# if __name__ == "__main__":
#   num1 = sys.argv[1]
#   num2 = sys.argv[2]
#   num3 = sys.argv[3]
#   print(get_sum_of_num(num1, num2, num3))

# This application will accept any input and fail at runtime if the inputs aren't correct.
# For example, if we parsed a string instead integer it would fail and send this message:
# python test.py 1 2 b
# ValueError: invalid literal for int() with base 10: 'b'

# There are better options, if you can avoid it, don’t use the sys module. Comes option 2.

# Option 2 — Argparse module
# The Argparse module provides more options as compared to the sys module. These options include:

# Default values for arguments
# Help messages
# Specifying the data type of the arguments

# To find more options and documentation run the following in your command line:
# python
# >>> import argparse
# >>> help(argparse)

import argparse

def get_sum_of_nums(num1,num2,num3):
  return(int(num1)+int(num2)+int(num3))

if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        description="Script that adds 3 numbers from CMD"
    )
    parser.add_argument("--num1", required=True, type=int)
    parser.add_argument("--num2", required=True, type=int)
    parser.add_argument("--num3", required=True, type=int)
    args = parser.parse_args()

    num1 = args.num1
    num2 = args.num2
    num3 = args.num3

    print(get_sum_of_nums(num1, num2, num3))

    # Running the script from the command line.
python tests.py --num1=1 --num2=2 --num3=3


Being able to control what arguments are required changes your programming dramatically. Requiring the inputs to be defined explicitly makes it easy to get arguments with little chance to error.
There are no assumptions of which value matches which argument based on position.

# help
parser.add_argument("--num3", required=True, type=int, help="Enter third number")
# If you run:
python test.py -h - num1


output:
Script that adds 3 numbers from CMD

optional arguments:
  -h, --help   show this help message and exit
  --num1 NUM1  Enter third number
  --num2 NUM2  Enter second number
  --num3 NUM3  Enter first number

# default
# The default value will be used any time an argument is not provided.
parser.add_argument("--num3", required=True, type=int, default=1, help="Enter third number")


When it comes to error handling, let's say a user enters the wrong type in one of the arguments:

python test.py --num1=1 --num2=2 --num3='b'
usage: test.py [-h] --num1 NUM1 --num2 NUM2 --num3 NUM3
test.py: error: argument --num3: invalid int value: 'b'

