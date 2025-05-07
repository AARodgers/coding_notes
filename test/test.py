import pandas as pd
import random

def create_fake_dataframe():
    # Define some random strings to populate the DataFrame
    random_strings = ['apple', 'banana', 'cherry', 'date', 'fig', 'grape', 'kiwi', 'lemon', 'mango', 'orange']

    # Generate random data for 4 columns
    data = {
        'col1': [random.choice(random_strings) for _ in range(10)],  # Random strings for col1
        'col2': [random.choice(random_strings) for _ in range(10)],  # Random strings for col2
        'col3': [random.choice(random_strings) for _ in range(10)],  # Random strings for col3
        'col4': [random.choice(random_strings) for _ in range(10)]   # Random strings for col4
    }

    # Create the DataFrame
    fake_df = pd.DataFrame(data)

    return fake_df

# Create and print the fake DataFrame
# fake_df = create_fake_dataframe()
# print(fake_df)

def get_non_matching_rows(df, col1, col2):
    """
    Returns a new DataFrame containing rows where the values in col1 and col2 are not the same.

    Args:
        df (pd.DataFrame): The input DataFrame.
        col1 (str): The name of the first column.
        col2 (str): The name of the second column.

    Returns:
        pd.DataFrame: A new DataFrame with rows where col1 != col2.
    """
    # Filter rows where col1 and col2 are not the same
    non_matching_df = df[df[col1] != df[col2]]

    return non_matching_df


def main():
    # Create a fake DataFrame
    fake_df = create_fake_dataframe()

    # Print the original DataFrame
    print("Original DataFrame:")
    print(fake_df)

    # Get non-matching rows between col1 and col2
    non_matching_rows = get_non_matching_rows(fake_df, 'col1', 'col2')

    # Print the non-matching rows
    print("\nNon-matching rows between col1 and col2:")
    print(type(non_matching_rows))
    print(non_matching_rows)

if __name__ == "__main__":
    main()
