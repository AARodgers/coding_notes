import pandas as pd
import os

def calculate_metrics_from_excel(file_path):
    """
    Imports an Excel sheet with columns TP, TN, FP, FN and calculates precision and accuracy.

    Args:
        file_path (str): Path to the Excel file.

    Returns:
        dict: A dictionary containing calculated metrics (precision, accuracy, etc.).
    """
    # Load the Excel file into a DataFrame
    df = pd.read_csv(file_path)

    # Calculate totals for TP, TN, FP, FN
    tp = df['TP'].sum()
    tn = df['TN'].sum()
    fp = df['FP'].sum()
    fn = df['FN'].sum()

    # Calculate metrics
    precision = tp / (tp + fp) if (tp + fp) > 0 else 0
    accuracy = (tp + tn) / (tp + tn + fp + fn) if (tp + tn + fp + fn) > 0 else 0
    recall = tp / (tp + fn) if (tp + fn) > 0 else 0
    f1_score = (2 * precision * recall) / (precision + recall) if (precision + recall) > 0 else 0

    # Return metrics in a dictionary
    return {
        'Precision': precision,
        'Accuracy': accuracy,
        'Recall': recall,
        'F1 Score': f1_score
    }

# Example usage
file_path = "/Users/amandarodgers/Documents/coding_stuff/data/fake_metrics.csv"
metrics = calculate_metrics_from_excel(file_path)

# Print the calculated metrics
print(metrics)
