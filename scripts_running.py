# Python Script:
# Definition:

# A Python script is a file containing Python code that is intended to be executed as a standalone program.
# Purpose:

# Scripts are typically used to perform a specific task or a sequence of tasks. They are often written to automate processes, perform data analysis, or run a series of commands.
# Execution:

# Python scripts are executed from the command line or an integrated development environment (IDE). The code runs from top to bottom, and once it completes, the script terminates.

# script.py
print("This is a Python script.")
for i in range(5):
    print(i)

# To run the script, you would use the command:
python script.py

### How to run scripts and functions from repos

# Option 1: ( use python interpreter to run the script )
1. get in correct Environment
2. got to the directory repot on main branch and git pull
3. go to folder with the file of the function you want to run
4. in terminal: python3 to start python interpreter
5. import the file and function: from file_name import function_name
6. wait for prompt
7. run the function: function_name(arguments)
8. exit()


# Option 2: ( create a script file and run it)
1. create a new file in the same folder oas the file with the function you want to run
touch run_script.py
2. in file:
    from file_name import function_name
#Call the function
    result = function_name(arguments)
# Print the result
    print(result)
3. run script in terminal:
python3 run_script.py


# Option 3:  ( modify file to make it executable with __main__):
1. add to bottom of file: if __name__ == "__main__":
                        function_name(arguments)
2. Execute file directory in terminal:
python3 file_name.py


# Option 4: (run using -c for inline execution):
1. python3 -c "from file_name import function_name; function_name(arguments)"
# note if there is no print you need to add print in the function to see the output
python3 -c "from file_name import function_name; print(function_name(arguments))"
