# Python Module:
# Definition:

# A Python module is a file containing Python code that defines functions, classes, and variables. Modules are meant to be imported and used in other Python programs.
# Purpose:

# Modules are used to organize and reuse code across multiple programs. They help in creating modular and maintainable code by encapsulating functionality in separate files.
# Importing:

# Modules are imported into other Python scripts or modules using the import statement. This allows you to access the functions, classes, and variables defined in the module.

# my_module.py
def greet(name):
    return f"Hello, {name}!"

def add(a, b):
    return a + b

# To use the module in another script:
# main.py
import my_module

print(my_module.greet("Alice"))
print(my_module.add(3, 4))

# Key Differences:
# Execution vs. Import:

# A script is executed directly, while a module is imported and used in other scripts or modules.
# Purpose:

# Scripts are designed to perform specific tasks, while modules are designed to encapsulate and reuse functionality.
# Usage:

# Scripts are run as standalone programs, whereas modules are imported and used within other Python code.
