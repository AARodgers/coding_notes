#!/bin/bash

# Purpose of script: Ask user for 2 integers and then determine if their sum is
# greater than, less than, or equal to their product. Add a resonpse to the user
# for each case.

# 1. Create a bash script file and make executable
# echo '#!/bin/bash' > basic_math.sh
# chmod u+x basic_math.sh
# check permissions with: ls -l basic_math.sh

# 2. Prompt user for two integers,
#!/bin/bash

echo -n "Enter an integer: "
read n1
echo -n "Enter another integer: "
read n2

sum=$(($n1+$n2))
product=$(($n1*$n2))

echo "The sum of $n1 and $n2 is $sum"
echo "The product of $n1 and $n2 is $product."

if [ $sum -lt $product ]
then
   echo "The sum is less than the product."
elif [ $sum -eq $product ]
then
   echo "The sum is equal to the product."
elif [ $sum -gt $product ]
then
   echo "The sum is greater than the product."
fi
