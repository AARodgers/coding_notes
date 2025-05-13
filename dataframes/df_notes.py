To combine two DataFrames into one in Python, you can use the **pandas** library, which provides several methods depending on how you want to combine the data. Here are the most common approaches:

---

### **1. Combine by Stacking Rows (Vertical Concatenation)**
If the two DataFrames have the same columns, you can combine them by stacking one on top of the other using `pd.concat()`.

#### Example:
```python
import pandas as pd

# Create two DataFrames
df1 = pd.DataFrame({'A': [1, 2], 'B': [3, 4]})
df2 = pd.DataFrame({'A': [5, 6], 'B': [7, 8]})

# Combine by stacking rows
result = pd.concat([df1, df2], ignore_index=True)

print(result)
```

**Output**:
```
   A  B
0  1  3
1  2  4
2  5  7
3  6  8
```

- **`ignore_index=True`**: Resets the index in the combined DataFrame.

---

### **2. Combine by Adding Columns (Horizontal Concatenation)**
If the two DataFrames have the same number of rows, you can combine them side by side using `pd.concat()` with `axis=1`.

#### Example:
```python
# Create two DataFrames
df1 = pd.DataFrame({'A': [1, 2]})
df2 = pd.DataFrame({'B': [3, 4]})

# Combine by adding columns
result = pd.concat([df1, df2], axis=1)

print(result)
```

**Output**:
```
   A  B
0  1  3
1  2  4
```

- **`axis=1`**: Combines the DataFrames column-wise.

---

### **3. Combine by Matching a Common Column (SQL-like Join/Merge)**
If the two DataFrames share a common column, you can combine them using `pd.merge()`.

#### Example:
```python
# Create two DataFrames
df1 = pd.DataFrame({'ID': [1, 2], 'Name': ['Alice', 'Bob']})
df2 = pd.DataFrame({'ID': [1, 2], 'Age': [25, 30]})

# Combine by matching the 'ID' column
result = pd.merge(df1, df2, on='ID')

print(result)
```

**Output**:
```
   ID   Name  Age
0   1  Alice   25
1   2    Bob   30
```

- **`on='ID'`**: Specifies the column to merge on.
- You can also specify the type of join:
  - `how='inner'` (default): Keeps only matching rows.
  - `how='left'`: Keeps all rows from the left DataFrame.
  - `how='right'`: Keeps all rows from the right DataFrame.
  - `how='outer'`: Keeps all rows from both DataFrames.

---

### **4. Combine by Index**
If you want to combine two DataFrames based on their index, you can use `pd.concat()` or `pd.merge()` with the `left_index` and `right_index` parameters.

#### Example:
```python
# Create two DataFrames
df1 = pd.DataFrame({'A': [1, 2]}, index=['a', 'b'])
df2 = pd.DataFrame({'B': [3, 4]}, index=['a', 'b'])

# Combine by index
result = pd.merge(df1, df2, left_index=True, right_index=True)

print(result)
```

**Output**:
```
   A  B
a  1  3
b  2  4
```

---

### **5. Append Rows from One DataFrame to Another**
If you want to add rows from one DataFrame to another, you can use `pd.concat()` or the deprecated `append()` method.

#### Example:
```python
result = df1.append(df2, ignore_index=True)
```

---

### **Summary of Methods**
| **Method**        | **Use Case**                                   | **Example**                  |
|--------------------|-----------------------------------------------|------------------------------|
| `pd.concat()`      | Combine rows or columns                      | Stacking or side-by-side     |
| `pd.merge()`       | Combine based on a common column or index    | SQL-like joins               |
| `append()`         | Add rows to the end of another DataFrame      | Deprecated, use `concat`     |

---

###################################

# Calculate how many unique values are in a specified column
# did it outside of function and needed single quotes around the column name
import pandas as pd

def count_unique_values(dataframe, column_name):
    """
    This function takes in a pandas DataFrame and a column name,
    and returns the number of unique values in that column.

    Parameters:
        dataframe (pd.DataFrame): The input DataFrame.
        column_name (str): The name of the column.

    Returns:
        int: The number of unique values in the column.
    """
    if column_name not in dataframe.columns:
        raise ValueError(f"Column '{column_name}' does not exist in the DataFrame.")

    return dataframe[column_name].nunique()

# Example usage
if __name__ == "__main__":
    # Example DataFrame
    df = pd.DataFrame({
        'A': [1, 2, 2, 3, 4],
        'B': ['apple', 'banana', 'apple', 'orange', 'banana']
    })

    # Count unique values in column 'A'
    unique_count = count_unique_values(df, 'A')
    print(f"Number of unique values in column 'A': {unique_count}")

    # Count unique values in column 'B'
    unique_count = count_unique_values(df, 'B')
    print(f"Number of unique values in column 'B': {unique_count}")
