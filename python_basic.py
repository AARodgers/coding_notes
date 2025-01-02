# A tuple is immutable, while a list is mutable.

# List: Mutable: You can change the elements of a list after it is created. This means you can add, remove, or modify elements.
my_list = [1, 2, 3]
my_list[0] = 10  # Modifying an element
my_list.append(4)  # Adding an element

# Tuple: Immutable: You cannot change the elements of a tuple after it is created. This means you cannot add, remove, or modify elements.
my_tuple = (1, 2, 3)
my_tuple[0] = 10  # This will raise an error

# Key Features of a Series:
# One-Dimensional:

# A Series is a single column of data, with each element having a unique label (also known as an index).
# Labeled:

# Each element in a Series has an associated label or index, which allows for easy access and manipulation of data.
# Flexible Data Types:

# A Series can hold various data types, including integers, floats, strings, and even Python objects.
# Creating a Series:
# You can create a Series using the pandas library in Python. Here are a few examples:

# Example 1: Creating a Series from a List
import pandas as pd

data = [10, 20, 30, 40]
series = pd.Series(data)
print(series)
#Output
0    10
1    20
2    30
3    40
dtype: int64

# Example 2: Creating a Series with Custom Index
import pandas as pd

data = [10, 20, 30, 40]
index = ['a', 'b', 'c', 'd']
series = pd.Series(data, index=index)
print(series)

#Output:
a    10
b    20
c    30
d    40
dtype: int64

#Accessing Elements in a Series:
# You can access elements in a Series using their index labels or numerical index positions.

# Example 3: Accessing Elements
import pandas as pd

data = [10, 20, 30, 40]
index = ['a', 'b', 'c', 'd']
series = pd.Series(data, index=index)

# Accessing by index label
print(series['b'])  # Output: 20

# Accessing by numerical index
print(series[2])  # Output: 30

# Summary of a Series:
# Series: A one-dimensional labeled array in pandas.
# Key Features: One-dimensional, labeled, flexible data types.
# Creation: Can be created from lists, dictionaries, and other data structures.
# Access: Elements can be accessed using index labels or numerical positions.
