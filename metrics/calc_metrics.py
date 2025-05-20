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

####################################

# To visualize which threshold is best using precision, recall and F1 scores

import matplotlib.pyplot as plt

thresholds = [0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0]
precision = [0.33, 0.40, 0.44, 0.43, 0.71, 0.83, 0.91]
recall = [0.10, 0.40, 0.80, 0.90, 0.96, 0.98, 1.00]
f1_score = [0.15, 0.40, 0.57, 0.58, 0.82, 0.90, 0.95]

plt.figure(figsize=(10, 6))
plt.plot(thresholds, precision, label='Precision', marker='o')
plt.plot(thresholds, recall, label='Recall', marker='o')
plt.plot(thresholds, f1_score, label='F1-Score', marker='o')
plt.xlabel('Threshold')
plt.ylabel('Metric Value')
plt.title('Precision, Recall, and F1-Score vs Threshold')
plt.legend()
plt.grid()
plt.show()

############################################################

Threshold Range	TP	FP	TN	FN	Precision	Recall	FPR	F1-Score
0.0–0.1	0	0	1000	50	N/A	0.00	0.00	N/A
0.1–0.2	5	10	990	45	0.33	0.10	0.01	0.15
0.2–0.3	20	30	970	30	0.40	0.40	0.03	0.40
0.3–0.4	40	50	950	10	0.44	0.80	0.05	0.57
0.4–0.5	45	60	940	5	0.43	0.90	0.06	0.58
0.5–0.6	48	20	980	2	0.71	0.96	0.02	0.82
0.6–0.7	49	10	990	1	0.83	0.98	0.01	0.90
0.7–1.0	50	5	995	0	0.91	1.00	0.005	0.95

################################################
