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


####################################################
**IPython** (Interactive Python) is an advanced, interactive shell for Python that provides a more powerful and user-friendly environment for programming compared to the standard Python shell. It is widely used by developers, data scientists, and researchers for tasks such as exploratory data analysis, debugging, and prototyping.

---

### **Key Features of IPython**

1. **Interactive Computing**:
   - IPython allows you to interactively execute Python code, making it ideal for experimentation and iterative workflows.
   - You can run code line-by-line, inspect variables, and modify code without restarting the session.

2. **Enhanced Shell**:
   - IPython provides features like syntax highlighting, auto-completion, and better error messages compared to the standard Python shell.

3. **Magic Commands**:
   - IPython introduces special commands called **magic commands** (e.g., `%time`, `%run`, `%matplotlib`) to simplify common tasks like timing code execution, running scripts, or integrating with plotting libraries.
   - Example:
     ```python
     %time sum(range(1000000))  # Times the execution of the code
     ```

4. **Rich Outputs**:
   - IPython supports rich media outputs, including images, videos, HTML, and LaTeX, making it useful for displaying results in a visually appealing way.

5. **Integration with Jupyter**:
   - IPython is the underlying kernel for Jupyter Notebooks, enabling interactive computing in notebooks.
   - It allows you to mix code, text (Markdown), and visualizations in a single document.

6. **Extensibility**:
   - IPython can be extended with plugins and custom scripts to add new functionality.
   - It supports integration with libraries like NumPy, pandas, matplotlib, and more.

7. **Parallel Computing**:
   - IPython includes tools for parallel computing, allowing you to run code across multiple processors or machines.

---

### **How to Use IPython**

#### **Installing IPython**
You can install IPython using pip or conda:
```bash
pip install ipython
```
or
```bash
conda install ipython
```

#### **Starting IPython**
Once installed, you can start IPython by typing `ipython` in your terminal:
```bash
$ ipython
Python 3.x.x (default, ...)
Type "help", "copyright", "credits" or "license" for more information.

In [1]: # You can start writing Python code here
```

#### **Basic Usage**
- **Run Python Commands**:
  ```python
  In [1]: print("Hello, IPython!")
  Out[1]: Hello, IPython!
  ```
- **Use Magic Commands**:
  ```python
  In [2]: %time sum(range(1000000))
  Out[2]: CPU times: user 12 ms, sys: 0 ms, total: 12 ms
          Wall time: 11.7 ms
          499999500000
  ```
- **Access System Commands**:
  - You can run shell commands directly from IPython using `!`:
    ```python
    In [3]: !ls
    Out[3]: file1.py  file2.csv
    ```

---

### **IPython vs. Standard Python Shell**

| **Feature**              | **IPython**                      | **Standard Python Shell**          |
|---------------------------|-----------------------------------|-------------------------------------|
| **Auto-Completion**       | Yes                              | No                                  |
| **Syntax Highlighting**   | Yes                              | No                                  |
| **Magic Commands**        | Yes                              | No                                  |
| **Rich Media Outputs**    | Yes                              | No                                  |
| **Shell Integration**     | Yes (`!ls`, `!pwd`, etc.)        | Limited                             |
| **Error Messages**        | More informative and readable    | Basic                               |

---

### **Use Cases**
1. **Exploratory Data Analysis**:
   - IPython is ideal for experimenting with data using libraries like pandas, NumPy, and matplotlib.

2. **Debugging**:
   - With features like `%debug`, IPython makes debugging easier by allowing you to inspect variables interactively.

3. **Prototyping**:
   - Quickly test and iterate on code without the need to write full scripts.

4. **Parallel Computing**:
   - Use IPython's parallel computing features to scale computations across multiple processors.

5. **Interactive Education**:
   - IPython is often used in teaching Python, as it provides an interactive and visual way to learn.

---

### **Example Workflow**
```python
# Start an IPython session
$ ipython

# Import libraries
In [1]: import pandas as pd
        import matplotlib.pyplot as plt

# Load and inspect data
In [2]: df = pd.read_csv('data.csv')
        df.head()

# Perform analysis
In [3]: df.describe()

# Plot results
In [4]: df['column_name'].plot()
        plt.show()

# Use a magic command to time an operation
In [5]: %time df['column_name'].mean()
```

---

#################################################################
