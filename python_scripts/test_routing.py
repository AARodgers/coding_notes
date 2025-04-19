import pandas as pd

# data = {
#     'Bank Name': ['Bank A', 'Bank B', 'Bank C'],
#     'Routing Number': [111000025, 111000038, 111000123]
# }
# df = pd.DataFrame(data)

# data2 = {
#     'Bank Name': ['Bank X', 'Bank Y', 'Bank Z'],
#     'Routing Number': [111000025, 111000038, 111000123]
# }
# csv_df = pd.DataFrame(data2)

# # print(df.head())       # Inspect the first few rows of the DataFrame
# # print(csv_df.head())   # Inspect the first few rows of the CSV DataFrame

# # Merge the DataFrames on Routing Number
# merged_df = pd.merge(df, csv_df, on='Routing Number', suffixes=('_df', '_csv'))

# # Inspect the merged DataFrame
# print(merged_df)

###########################################################

import pandas as pd
import argparse

def match_bank_names(df_path, csv_path, output_path=None):
    """
    Matches bank names from a DataFrame and a CSV file based on routing numbers.

    Parameters:
    df_path (str): Path to the DataFrame file (CSV format).
    csv_path (str): Path to the CSV file containing bank names and routing numbers.
    output_path (str, optional): Path to save the merged DataFrame as a CSV file. If None, the result is printed.

    Returns:
    None
    """
    # Load the DataFrame
    print(f"Loading DataFrame from: {df_path}")
    df = pd.read_csv(df_path)

    # Load the CSV file
    print(f"Loading CSV file from: {csv_path}")
    csv_df = pd.read_csv(csv_path)

    # Check if 'Routing Number' column exists in both files
    if 'Routing Number' not in df.columns or 'Routing Number' not in csv_df.columns:
        raise ValueError("Both files must contain a 'Routing Number' column.")

    # Merge the DataFrames on Routing Number
    print("Matching bank names based on routing numbers...")
    merged_df = pd.merge(df, csv_df, on='Routing Number', how='inner', suffixes=('_df', '_csv'))

    # Display the result
    print("\nMerged DataFrame:")
    print(merged_df)

    # Save the result to a CSV file if output_path is provided
    if output_path:
        print(f"Saving merged DataFrame to: {output_path}")
        merged_df.to_csv(output_path, index=False)
        print("File saved successfully.")

if __name__ == "__main__":
    # Set up argument parsing
    parser = argparse.ArgumentParser(description="Match bank names between a DataFrame and a CSV file by routing number.")
    parser.add_argument("df_path", type=str, help="Path to the DataFrame file (CSV format).")
    parser.add_argument("csv_path", type=str, help="Path to the CSV file containing bank names and routing numbers.")
    parser.add_argument("--output_path", type=str, default=None, help="Path to save the merged DataFrame as a CSV file (optional).")

    # Parse arguments
    args = parser.parse_args()

    # Run the matching function
    match_bank_names(args.df_path, args.csv_path, args.output_path)

    #######################################################

#     To run the script in the command line, follow these steps:

# ---

### **Steps to Run the Script**

#### **1. Save the Script**
# Save the Python script as `match_banks.py` in a directory on your computer.

# ---

# #### **2. Open the Terminal**
# Open your terminal or command prompt.

# ---

# #### **3. Navigate to the Directory**
# Use the `cd` command to navigate to the directory where the script is saved.

# ```bash
# cd /path/to/directory
# ```

# ---

#### **4. Run the Script**
# Run the script by providing the paths to the CSV files as arguments.

# #### **Basic Command**:
# ```bash
# python match_banks.py path_to_dataframe.csv path_to_csv.csv
# ```

# ##### **Example**:
# If your files are named `df.csv` and `routing.csv` and are located in the same directory as the script:
# ```bash
# python match_banks.py df.csv routing.csv
# ```

# ---

# #### **5. Save the Output (Optional)**
# If you want to save the merged DataFrame to a new CSV file, use the `--output_path` argument.

# #### **Command with Output File**:
# ```bash
# python match_banks.py df.csv routing.csv --output_path merged_banks.csv
# ```

# This will save the result to a file named `merged_banks.csv` in the same directory.

# ---

# ### **Example Execution**

# #### **Command**:
# ```bash
# python match_banks.py df.csv routing.csv --output_path merged_output.csv
# ```

# #### **Output**:
# The merged DataFrame will be saved to `merged_output.csv`.

# ---

# ### **Troubleshooting**
# 1. **Python Not Found**:
#    - If `python` is not recognized, try `python3` instead:
#      ```bash
#      python3 match_banks.py df.csv routing.csv
#      ```

# 2. **File Not Found**:
#    - Ensure the file paths (`df.csv` and `routing.csv`) are correct and accessible.
#    - Use absolute paths if the files are in different directories:
#      ```bash
#      python match_banks.py /full/path/to/df.csv /full/path/to/routing.csv
#      ```

# 3. **Permission Issues**:
#    - If you encounter permission errors, ensure the script and CSV files have the appropriate read/write permissions.

# ---

# ### **Summary**
# To run the script:
# 1. Save the script as `match_banks.py`.
# 2. Open the terminal and navigate to the script's directory.
# 3. Run the command:
#    ```bash
#    python match_banks.py path_to_dataframe.csv path_to_csv.csv
#    ```
# 4. Optionally, add `--output_path` to save the result to a file.

# This will execute the script and either print the merged DataFrame or save it to a specified output file.
