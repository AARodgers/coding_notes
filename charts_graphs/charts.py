# Chart distribution of values in a specified column in a DataFrame
import pandas as pd
import matplotlib.pyplot as plt

def plot_routing_number_distribution(df, column_name):
    """
    This function takes a DataFrame and a column name containing routing numbers,
    calculates the distribution of lengths, and plots a bar chart.

    Parameters:
        df (pd.DataFrame): The input DataFrame.
        column_name (str): The name of the column containing routing numbers.

    Returns:
        None
    """
    # Ensure the column exists in the DataFrame
    if column_name not in df.columns:
        raise ValueError(f"Column '{column_name}' does not exist in the DataFrame.")

    # Calculate the length of each routing number
    df['length'] = df[column_name].astype(str).apply(len)

    # Count the occurrences of each length
    length_distribution = df['length'].value_counts().sort_index()

    # Plot the distribution
    plt.figure(figsize=(8, 6))
    length_distribution.plot(kind='bar', color='skyblue', edgecolor='black')
    plt.title('Distribution of Routing Number Lengths', fontsize=14)
    plt.xlabel('Routing Number Length', fontsize=12)
    plt.ylabel('Count', fontsize=12)
    plt.xticks(rotation=0)
    plt.grid(axis='y', linestyle='--', alpha=0.7)
    plt.show()

# Example usage
if __name__ == "__main__":
    # Example DataFrame
    data = {'rtn': [123456789, 12345678, 1234567, 123456789, 12345, 123456]}
    df = pd.DataFrame(data)

    # Plot the distribution of routing number lengths
    plot_routing_number_distribution(df, 'rtn')

# The above code will create a bar chart showing the distribution of lengths of routing numbers in the specified column.
# The x-axis will represent the lengths of the routing numbers, and the y-axis will show the count of occurrences for each length.


