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

#############################################################

import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

def plot_match_probabilities_distribution(df, column_name, bins=30, plot_type="histogram"):
    """
    Plots the distribution of match probabilities from a specified column in a DataFrame.

    Parameters:
    - df (pd.DataFrame): The input DataFrame.
    - column_name (str): The name of the column containing match probabilities.
    - bins (int): Number of bins for the histogram (default: 30).
    - plot_type (str): The type of plot to create. Options are "histogram" or "density" (default: "histogram").

    Returns:
    - None: Displays the plot.
    """
    # Ensure the column exists in the DataFrame
    if column_name not in df.columns:
        raise ValueError(f"Column '{column_name}' does not exist in the DataFrame.")

    # Check for valid plot type
    if plot_type not in ["histogram", "density"]:
        raise ValueError("plot_type must be either 'histogram' or 'density'.")

    # Plot the distribution
    plt.figure(figsize=(10, 6))
    if plot_type == "histogram":
        sns.histplot(df[column_name], bins=bins, kde=False, color="blue", edgecolor="black")
        plt.title(f"Histogram of {column_name}", fontsize=16)
        plt.xlabel("Match Probabilities", fontsize=12)
        plt.ylabel("Frequency", fontsize=12)
    elif plot_type == "density":
        sns.kdeplot(df[column_name], shade=True, color="blue")
        plt.title(f"Density Plot of {column_name}", fontsize=16)
        plt.xlabel("Match Probabilities", fontsize=12)
        plt.ylabel("Density", fontsize=12)

    # Display the plot
    plt.grid(axis='y', linestyle='--', alpha=0.7)
    plt.tight_layout()
    plt.show()

# Sample DataFrame with match probabilities
data = {
    'match_probabilities': [0.1, 0.2, 0.3, 0.7, 0.8, 0.95, 0.99, 0.5, 0.6, 0.4]
}
df = pd.DataFrame(data)

# Plot the histogram of match probabilities
plot_match_probabilities_distribution(df, column_name='match_probabilities', bins=20, plot_type="histogram")

# Plot the density of match probabilities
plot_match_probabilities_distribution(df, column_name='match_probabilities', plot_type="density")
  #################################################
