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


##############################################################

Here’s a Python function that calculates and prints out precision, accuracy, F1-score, and recall based on the input values for True Positives (TP), True Negatives (TN), False Positives (FP), and False Negatives (FN):

def calculate_metrics(tp, tn, fp, fn):
    """
    Calculates and prints precision, accuracy, F1-score, and recall based on TP, TN, FP, FN.

    Parameters:
    - tp (int): True Positives
    - tn (int): True Negatives
    - fp (int): False Positives
    - fn (int): False Negatives

    Returns:
    - dict: A dictionary containing precision, accuracy, recall, and F1-score.
    """
    # Calculate precision
    precision = tp / (tp + fp) if (tp + fp) > 0 else 0

    # Calculate recall
    recall = tp / (tp + fn) if (tp + fn) > 0 else 0

    # Calculate accuracy
    accuracy = (tp + tn) / (tp + tn + fp + fn) if (tp + tn + fp + fn) > 0 else 0

    # Calculate F1-score
    f1_score = (2 * precision * recall) / (precision + recall) if (precision + recall) > 0 else 0

    # Print metrics
    print(f"Precision: {precision:.2f}")
    print(f"Recall: {recall:.2f}")
    print(f"Accuracy: {accuracy:.2f}")
    print(f"F1-Score: {f1_score:.2f}")

    # Return metrics as a dictionary
    return {
        "precision": precision,
        "recall": recall,
        "accuracy": accuracy,
        "f1_score": f1_score
    }

# Example input values for TP, TN, FP, FN
tp = 50  # True Positives
tn = 30  # True Negatives
fp = 10  # False Positives
fn = 20  # False Negatives

# Calculate and print metrics
metrics = calculate_metrics(tp, tn, fp, fn)

# Access metrics as a dictionary
print(metrics)


