import pandas as pd

def group_predictions_by_bank_name(predictions_df):
    """
    Groups predictions by bank_name and unique_id into a dictionary.

    Args:
        predictions_df (pd.DataFrame): A DataFrame containing predictions with 'bank_name' and 'unique_id' columns.

    Returns:
        dict: A dictionary where keys are bank names, and values are lists of unique_ids.
    """
    # Initialize an empty dictionary
    grouped_predictions = {}

    # Iterate over the rows of the DataFrame
    for _, row in predictions_df.iterrows():
        bank_name = row['bank_name']
        unique_id = row['unique_id']

        # Add the bank_name as a key if it doesn't exist
        if bank_name not in grouped_predictions:
            grouped_predictions[bank_name] = []

        # Append the unique_id to the corresponding bank_name key
        grouped_predictions[bank_name].append(unique_id)

    return grouped_predictions

# How It Works
# Input:

# The function takes a predictions_df DataFrame with at least two columns: bank_name and unique_id.
# Logic:

# Iterate through each row of the DataFrame using iterrows().
# Group the unique_id values under their respective bank_name keys in a dictionary.
# Output:

# A dictionary with bank_name as the key and a list of unique_ids as the value.

import pandas as pd

# Example DataFrame
data = {
    'bank_name': ['bank1', 'bank2', 'bank1', 'bank3', 'bank2'],
    'unique_id': [101, 102, 103, 104, 105]
}
predictions_df = pd.DataFrame(data)

# Call the function
result = group_predictions_by_bank_name(predictions_df)

# Print the result
print(result)

# Output:

{
    'bank1': [101, 103],
    'bank2': [102, 105],
    'bank3': [104]
}

# Notes
# Ensure the column names in the DataFrame match those used in the function (bank_name and unique_id).
# If you have duplicate rows in the DataFrame, you may want to drop duplicates before applying the function:

####################################################################

