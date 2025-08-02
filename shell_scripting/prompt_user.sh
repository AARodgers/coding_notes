#!/bin/bash

# 1. Create a bash script file and make executable
# echo '#!/bin/bash' > prompt_user.sh
# chmod u+x prompt_user.sh

# 2. Prompt the user for input with binary prompt and store response
#!/bin/bash
echo 'Are you happy?'
echo -n "Enter \"y\" for yes, \"n\" for no."
read response

if [ "$response" = "y" ]
then
    echo "Good!"
elif [ "$response" = "n" ]
then
   echo "I'm sorry to hear that."
else
   echo "Your response must be either 'y' or 'n'."
   echo "Please re-run the script to try again."
fi
