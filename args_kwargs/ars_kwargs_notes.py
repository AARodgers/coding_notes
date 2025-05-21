def multiply(x, y):
    print (x * y)

multiply(5, 4, 3)


# We can essentially create the same function and code that we showed in the first example, by removing x and y as function parameters, and instead replacing them with *args:
def multiply(*args):
    z = 1
    for num in args:
        z *= num
    print(z)

multiply(4, 5)
multiply(10, 9)
multiply(2, 3, 4)
multiply(3, 5, 10, 6)

The double asterisk form of **kwargs is used to pass a keyworded, variable-length argument dictionary to a function. Again, the two asterisks (**) are the important element here, as the word kwargs is conventionally used, though not enforced by the language.

Like *args, **kwargs can take however many arguments you would like to supply to it. However, **kwargs differs from *args in that you will need to assign keywords.

First, let’s print out the **kwargs arguments that we pass to a function. We’ll create a short function to do this:

def print_kwargs(**kwargs):
        print(kwargs)

Next, we’ll call the function with some keyworded arguments passed into the function:

def print_kwargs(**kwargs):
        print(kwargs)

print_kwargs(kwargs_1="Shark", kwargs_2=4.5, kwargs_3=True)

Let’s run the program above and look at the output:

python print_kwargs.py
Output
{'kwargs_3': True, 'kwargs_2': 4.5, 'kwargs_1': 'Shark'}

Let’s create another short program to show how we can make use of **kwargs. Here we’ll create a function
to greet a dictionary of names. First, we’ll start with a dictionary of two names:

def print_values(**kwargs):
    for key, value in kwargs.items():
        print("The value of {} is {}".format(key, value))

print_values(my_name="Sammy", your_name="Casey")

# Output
# The value of your_name is Casey
# The value of my_name is Sammy

# Let’s now pass additional arguments to the function to show that **kwargs will accept however many arguments you would like to include:

def print_values(**kwargs):
    for key, value in kwargs.items():
        print("The value of {} is {}".format(key, value))

print_values(
            name_1="Alex",
            name_2="Gray",
            name_3="Harper",
            name_4="Phoenix",
            name_5="Remy",
            name_6="Val"
        )

Output
The value of name_2 is Gray
The value of name_6 is Val
The value of name_4 is Phoenix
The value of name_5 is Remy
The value of name_3 is Harper
The value of name_1 is Alex

Ordering Arguments
When ordering arguments within a function or function call, arguments need to occur in a particular order:

Formal positional arguments
*args
Keyword arguments
**kwargs

def example(arg_1, arg_2, *args, **kwargs):
...

And, when working with positional parameters along with named keyword parameters in addition to *args and **kwargs, your function would look like this:

def example2(arg_1, arg_2, *args, kw_1="shark", kw_2="blobfish", **kwargs):
...

It is important to keep the order of arguments in mind when creating functions so that you do not receive a syntax error in your Python code.

We can also use *args and **kwargs to pass arguments into functions.

def some_args(arg_1, arg_2, arg_3):
    print("arg_1:", arg_1)
    print("arg_2:", arg_2)
    print("arg_3:", arg_3)

args = ("Sammy", "Casey", "Alex")
some_args(*args)

In the function above, there are three parameters defined as arg_1, arg_, and arg_3. The function will print out each of these arguments. We then create a variable that is set to an iterable (in this case, a tuple), and can pass that variable into the function with the asterisk syntax.

Output
arg_1: Sammy
arg_2: Casey
arg_3: Alex

We can also modify the program above to an iterable list data type with a different variable name. Let’s also combine the *args syntax with a named parameter:

def some_args(arg_1, arg_2, arg_3):
    print("arg_1:", arg_1)
    print("arg_2:", arg_2)
    print("arg_3:", arg_3)

my_list = [2, 3]
some_args(1, *my_list)

Output
arg_1: 1
arg_2: 2
arg_3: 3

Similarly, the keyworded **kwargs arguments can be used to call a function. We will set up a variable equal to a dictionary with 3 key-value pairs (we’ll use kwargs here, but it can be called whatever you want), and pass it to a function with 3 arguments:

def some_kwargs(kwarg_1, kwarg_2, kwarg_3):
    print("kwarg_1:", kwarg_1)
    print("kwarg_2:", kwarg_2)
    print("kwarg_3:", kwarg_3)

kwargs = {"kwarg_1": "Val", "kwarg_2": "Harper", "kwarg_3": "Remy"}
some_kwargs(**kwargs)

Output
kwarg_1: Val
kwarg_2: Harper
kwarg_3: Remy

Article:
https://www.digitalocean.com/community/tutorials/how-to-use-args-and-kwargs-in-python-3


#############################

Python script that follows your requirements. We'll use the sys module to handle arguments passed to the script and pandas for loading the CSV files into dataframes.
Here’s a Python script that follows your requirements. We'll use the `sys` module to handle arguments passed to the script and `pandas` for loading the CSV files into dataframes.

---

### Script: `load_dataframes.py`

```python
import sys
import pandas as pd

def load_dataframe(file_path):
    """Loads a CSV file into a Pandas DataFrame."""
    try:
        df = pd.read_csv(file_path)
        print(f"Loaded dataframe from {file_path}")
        return df
    except FileNotFoundError:
        print(f"Error: The file at path {file_path} was not found.")
        sys.exit(1)
    except pd.errors.EmptyDataError:
        print(f"Error: The file at {file_path} is empty or invalid.")
        sys.exit(1)
    except Exception as e:
        print(f"An unexpected error occurred while loading {file_path}: {e}")
        sys.exit(1)

def main():
    """Main function to handle system arguments and load CSV files into DataFrames."""
    if len(sys.argv) != 3:
        print("Usage: python load_dataframes.py <path_to_dataframe1.csv> <path_to_dataframe2.csv>")
        sys.exit(1)

    # Get file paths from system arguments
    df1_path = sys.argv[1]
    df2_path = sys.argv[2]

    # Load the DataFrames
    df1 = load_dataframe(df1_path)
    df2 = load_dataframe(df2_path)

    # Print a summary of the DataFrames
    print("\n--- DataFrame 1 Summary ---")
    print(df1.info())
    print("\n--- DataFrame 2 Summary ---")
    print(df2.info())

if __name__ == '__main__':
    main()
```

---

### How It Works:
1. **CSV Loading with `pandas`:** The script includes a `load_dataframe` function that loads a CSV file into a Pandas DataFrame.
2. **System Arguments Handling:** The script expects exactly two arguments passed via the command line—paths to the two CSV files.
3. **Error Handling:** The script includes error handling for common issues, such as missing files, empty files, or invalid CSV formatting.
4. **Summarize the Loaded Data:** After loading, it prints a summary (`info()`) of each DataFrame to ensure they are loaded correctly.

---

### Running the Script:
1. Save the script as `load_dataframes.py`.
2. Run it from the command line, passing the file paths as arguments:
   ```bash
   python load_dataframes.py path_to_dataframe1.csv path_to_dataframe2.csv
   ```

Example:
```bash
python load_dataframes.py data1.csv data2.csv
```

---

### Sample `data1.csv`:
```csv
id,name,age
1,Amanda,30
2,John,25
3,Emily,35
```

### Sample `data2.csv`:
```csv
id,department,salary
1,Marketing,55000
2,Sales,60000
3,HR,52000
```

---

### Output Example:
```plaintext
Loaded dataframe from data1.csv
Loaded dataframe from data2.csv

--- DataFrame 1 Summary ---
<class 'pandas.core.frame.DataFrame'>
RangeIndex: 3 entries, 0 to 2
Data columns (total 3 columns):
 #   Column  Non-Null Count  Dtype
---  ------  --------------  -----
 0   id      3 non-null      int64
 1   name    3 non-null      object
 2   age     3 non-null      int64

--- DataFrame 2 Summary ---
<class 'pandas.core.frame.DataFrame'>
RangeIndex: 3 entries, 0 to 2
Data columns (total 3 columns):
 #   Column      Non-Null Count  Dtype
---  ----------  --------------  -----
 0   id          3 non-null      int64
 1   department  3 non-null      object
 2   salary      3 non-null      int64
```

---

#######################################
