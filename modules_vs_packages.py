# In Python, both modules and packages are used to organize and structure code, but they serve different purposes and have distinct characteristics.

# Module:
# Definition:

# A module is a single file containing Python code. It can define functions, classes, and variables, and can also include runnable code.
# File Extension:

# A module is simply a .py file.
# Purpose:

# Modules are used to break down large programs into smaller, manageable, and reusable pieces of code.
# Example:

# my_module.py
def greet(name):
    return f"Hello, {name}!"

def add(a, b):
    return a + b
Usage:

# Modules can be imported into other modules or scripts using the import statement.
# main.py
import my_module

print(my_module.greet("Alice"))
print(my_module.add(3, 4))
Package:
Definition:

# A package is a collection of modules organized in a directory hierarchy. It allows for a more structured and hierarchical organization of the code.
# Directory Structure:

# A package is a directory that contains a special __init__.py file (which can be empty) and one or more module files or sub-packages.
# Purpose:

# Packages are used to organize related modules into a single directory structure, making it easier to manage large codebases.
# Example Structure:

my_package/
├── __init__.py
├── module_a.py
└── sub_package/
    ├── __init__.py
    └── module_b.py

# Usage:

# Modules within a package can be imported using the import statement with dot notation.
# main.py
from my_package import module_a
from my_package.sub_package import module_b

print(module_a.some_function())
print(module_b.another_function())

# Key Differences:
# Structure:

# A module is a single .py file, while a package is a directory containing multiple modules and an __init__.py file.
# Organization:

# Modules are used to organize code within a single file, whereas packages are used to organize related modules within a directory structure.
# Importing:

# Modules are imported using their file name (without the .py extension), while packages are imported using dot notation to navigate the directory structure.
# Summary:
# Module: A single Python file (.py) containing code.
# Package: A directory containing multiple modules and an __init__.py file, used to organize related modules.
# Understanding the difference between modules and packages helps in organizing and structuring Python code more effectively, making it easier to manage, maintain, and reuse.
