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

#############################################

import pandas as pd

def add_leading_zero(df, column_name):
    """
    Adds a leading zero to the values in the specified column of a DataFrame.

    Parameters:
    - df (pd.DataFrame): The DataFrame to modify.
    - column_name (str): The name of the column to modify.

    Returns:
    - pd.DataFrame: The modified DataFrame with the leading zero added.
    """
    # Ensure the column exists in the DataFrame
    if column_name not in df.columns:
        raise ValueError(f"Column '{column_name}' does not exist in the DataFrame.")

    # Add a leading zero to each value in the column (convert to string first)
    df[column_name] = df[column_name].astype(str).apply(lambda x: f"0{x}" if not x.startswith("0") else x)

    return df

# Apply the function to add a leading zero to the 'rtn' column
fomf_top_100 = add_leading_zero(fomf_top_100, 'rtn')

# Display the modified DataFrame
print(fomf_top_100)

#####################################################################
 # Do same as above but only to values that are eight characters in length in that column
 Below is the updated function that adds a leading zero only to the values in the specified column that are exactly 8 characters long.

import pandas as pd

def add_leading_zero_to_eight_char_values(df, column_name):
    """
    Adds a leading zero to values in the specified column of a DataFrame
    only if the values are exactly 8 characters long.

    Parameters:
    - df (pd.DataFrame): The DataFrame to modify.
    - column_name (str): The name of the column to modify.

    Returns:
    - pd.DataFrame: The modified DataFrame with the leading zero added to qualifying values.
    """
    # Ensure the column exists in the DataFrame
    if column_name not in df.columns:
        raise ValueError(f"Column '{column_name}' does not exist in the DataFrame.")

    # Add a leading zero only to values with 8 characters
    df[column_name] = df[column_name].astype(str).apply(
        lambda x: f"0{x}" if len(x) == 8 else x
    )

    return df

# Apply the function to add a leading zero to the 'rtn' column for 8-character values
fomf_top_100 = add_leading_zero_to_eight_char_values(fomf_top_100, 'rtn')

# Display the modified DataFrame
print(fomf_top_100)

#######################################################

# Checks to see if df has duplicate rows

Python function that takes in a pandas DataFrame and checks for duplicate rows. The function will return either a boolean indicating whether duplicates exist, or a DataFrame containing the duplicate rows for further inspection.

import pandas as pd

def check_for_duplicates(df, return_duplicates=False):
    """
    Checks if a DataFrame contains duplicate rows.

    Parameters:
    - df (pd.DataFrame): The DataFrame to check for duplicates.
    - return_duplicates (bool): If True, returns the duplicate rows as a DataFrame.
                                 If False, returns a boolean indicating if duplicates exist.

    Returns:
    - bool or pd.DataFrame:
        - If return_duplicates=False: Returns True if duplicates exist, False otherwise.
        - If return_duplicates=True: Returns a DataFrame of duplicate rows.
    """
    # Find duplicate rows
    duplicate_rows = df[df.duplicated()]

    if return_duplicates:
        # Return the DataFrame of duplicate rows
        return duplicate_rows
    else:
        # Return True if duplicates exist, False otherwise
        return not duplicate_rows.empty

# Check if duplicates exist (boolean)
has_duplicates = check_for_duplicates(df)
print(f"Does the DataFrame have duplicates? {has_duplicates}")

# Get the duplicate rows (if any)
duplicate_rows = check_for_duplicates(df, return_duplicates=True)
print("Duplicate rows:")
print(duplicate_rows)

########################################################
Python function that takes in a DataFrame and creates a unique ID for each row based on the 5th to 8th digits of the routing number in the rtn column. The unique ID is added as a new column in the DataFrame.


import pandas as pd

def create_unique_id(df, routing_column, id_column_name='unique_id'):
    """
    Creates a unique ID for each row based on the 5th to 8th digits of the routing number
    in the specified column and adds it as a new column to the DataFrame.

    Parameters:
    - df (pd.DataFrame): The DataFrame to modify.
    - routing_column (str): The name of the column containing routing numbers.
    - id_column_name (str): The name of the new column to store the unique IDs (default: 'unique_id').

    Returns:
    - pd.DataFrame: The modified DataFrame with the new unique ID column.
    """
    # Ensure the routing column exists in the DataFrame
    if routing_column not in df.columns:
        raise ValueError(f"Column '{routing_column}' does not exist in the DataFrame.")

    # Extract the 5th to 8th digits of the routing number and create the unique ID
    df[id_column_name] = df[routing_column].astype(str).apply(lambda x: x[4:8] if len(x) >= 8 else None)

    return df

# Sample DataFrame
data = {
    'bank_name': ['Bank A', 'Bank B', 'Bank C'],
    'rtn': ['021000021', '123456789', '987654321']
}
fomf_df = pd.DataFrame(data)

# Apply the function to create unique IDs based on the 5th-8th digits of the routing number
fomf_df = create_unique_id(fomf_df, routing_column='rtn')

# Display the modified DataFrame
print(fomf_df)

#######################################################

# check if a column in a DataFrame has any duplicate values, you can use the duplicated() method in pandas

import pandas as pd

def check_column_duplicates(df, column_name):
    """
    Checks if a column in a DataFrame has any duplicate values.

    Parameters:
    - df (pd.DataFrame): The DataFrame to check.
    - column_name (str): The name of the column to check for duplicates.

    Returns:
    - bool: True if duplicates exist, False otherwise.
    - pd.Series: A Series of duplicate values (if duplicates exist).
    """
    # Ensure the column exists in the DataFrame
    if column_name not in df.columns:
        raise ValueError(f"Column '{column_name}' does not exist in the DataFrame.")

    # Check for duplicates in the column
    duplicates = df[column_name][df[column_name].duplicated()]

    # Return results
    if not duplicates.empty:
        return True, duplicates
    else:
        return False, None

# Sample DataFrame
data = {
    'bank_name': ['Bank A', 'Bank B', 'Bank C', 'Bank A'],
    'rtn': ['021000021', '123456789', '987654321', '021000021']
}
df = pd.DataFrame(data)

# Check for duplicates in the 'rtn' column
has_duplicates, duplicate_values = check_column_duplicates(df, 'rtn')

print(f"Does the 'rtn' column have duplicates? {has_duplicates}")
if has_duplicates:
    print("Duplicate values:")
    print(duplicate_values)

#############################################

# Group by routing number and count unique EINs
grouped = df.groupby('rtn')['ein'].nunique().reset_index()
grouped.columns = ['Routing Number', 'Unique EIN Count']

# Display routing numbers shared by multiple EINs
shared_routing_numbers = grouped[grouped['Unique EIN Count'] > 1]
print(shared_routing_numbers)

#############################################

Yes, it would generally be a **bad idea** to use the **5th–8th digits of the routing number** as the primary key for your DataFrame or dictionary. Here's why:

---

### **Why Using the 5th–8th Digits as a Primary Key is Problematic:**
1. **Non-Unique Values**:
   - The **5th–8th digits** of a routing number are not guaranteed to be unique across all routing numbers. Multiple banks or entities may share the same routing number, meaning the extracted digits could repeat, violating the uniqueness requirement of a primary key.

2. **Loss of Granularity**:
   - By using only part of the routing number (5th–8th digits), you lose the ability to distinguish between entities that share the same routing number but have different EINs or bank names.

3. **Potential Data Integrity Issues**:
   - If you use non-unique values as a primary key, your DataFrame or dictionary could overwrite data or fail to associate all relevant entities with the same routing number.

---

### **Recommended Approach:**

#### **1. Use a Composite Key**
Instead of relying solely on the 5th–8th digits of the routing number, consider using a **composite key** that combines multiple columns to ensure uniqueness. For example:
- Combine `routing number` and `EIN` as the composite key.
- This ensures that each row is uniquely identified even if multiple entities share the same routing number.

#### **Example in Python**:
```python
# Create a composite key by combining 'rtn' and 'ein'
df['primary_key'] = df['rtn'].astype(str) + "_" + df['ein'].astype(str)
```

This creates a unique key for each row by concatenating the routing number and EIN. For example:
- Routing Number: `021000021`, EIN: `123456789` → Primary Key: `021000021_123456789`.

---

#### **2. Group Data by Routing Number**
If your goal is to create a DataFrame or dictionary that lists all associated **bank names**, **EINs**, and **routing numbers**, you can group the data by routing number and aggregate the associated values.

#### Example:
```python
# Group by routing number and aggregate associated bank names and EINs
grouped_df = df.groupby('rtn').agg({
    'bank_name': lambda x: list(set(x)),  # List of unique bank names
    'ein': lambda x: list(set(x))        # List of unique EINs
}).reset_index()

# Convert to dictionary
routing_dict = grouped_df.to_dict(orient='records')

print(routing_dict)
```

#### Output Example:
```python
[
    {'rtn': '021000021', 'bank_name': ['Bank A', 'Bank B'], 'ein': ['123456789', '987654321']},
    {'rtn': '123456789', 'bank_name': ['Bank C'], 'ein': ['123450000']}
]
```

---

### **3. Use a Unique Identifier for Each Row**
If you need a strict primary key for your DataFrame, you can create a **unique identifier** for each row:
```python
df['unique_id'] = df.index  # Use the row index as a unique identifier
```
This ensures every row has a unique value, even if the routing numbers or EINs repeat.

---

### **Final Recommendation:**
- **Composite Key**: Use a combination of routing number and EIN for uniqueness.
- **Group Data**: If you want to create a summary of routing numbers with associated bank names and EINs, group by routing number and aggregate the data.
- **Avoid Using Partial Routing Numbers**: The 5th–8th digits alone are insufficient to ensure uniqueness and may lead to data integrity issues.

Let me know if you'd like help implementing these solutions or further refining your approach!
