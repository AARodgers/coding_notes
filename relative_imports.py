# A relative import in Python is a way to import modules or objects from a package using a relative path, rather than an absolute path. Relative imports are useful when you want to import modules from the same package or subpackage without specifying the full path.

# Key Points about Relative Imports:
# Syntax:

# Relative imports use dots (.) to indicate the current and parent directories.
# A single dot (.) refers to the current package.
# Two dots (..) refer to the parent package.
# Three dots (...) refer to the grandparent package, and so on.
# Context:

# Relative imports are typically used within packages to import sibling modules or modules from parent packages.
# Example Structure:

my_package/
├── __init__.py
├── module_a.py
└── sub_package/
    ├── __init__.py
    └── module_b.py
Example Usage:

# Suppose you want to import module_a from module_b using a relative import.
# module_b.py:

# module_b.py
from .. import module_a

def use_module_a():
    return module_a.some_function()

# In this example, from .. import module_a imports module_a from the parent package (my_package).
# Benefits of Relative Imports:
# Simplified Paths:
# Relative imports can make the code more readable by avoiding long, absolute paths.
# Portability:
# They make it easier to move packages around without needing to update import statements.
# Important Considerations:
# Use in Packages:
# Relative imports should be used within packages. They are not suitable for standalone scripts.
# PEP 8 Recommendation:
# PEP 8, the Python style guide, recommends using absolute imports for clarity, but relative imports can be useful in certain scenarios within packages.
# By understanding relative imports, you can better manage module dependencies within your packages and make your code more modular and maintainable.
