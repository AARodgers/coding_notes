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

Yes, **Splink's performance** can be affected by spaces in strings or names, depending on how the entity resolution model is configured and the comparison methods used. Here’s a breakdown of why spaces matter and whether removing them (e.g., turning `Nick Cave` into `NickCave` or `nickcave`) could improve performance:

---

### **Why Spaces Can Affect Performance**
1. **String Similarity Measures**:
   - Splink often uses **string similarity algorithms** (e.g., Levenshtein distance, Jaro-Winkler, or cosine similarity) to compare attribute values like names.
   - Spaces can increase the **edit distance** or reduce similarity scores between strings, even if the underlying names are the same.
     - For example, `Nick Cave` vs. `NickCave` will have a higher edit distance compared to `NickCave` vs. `NickCave`.

2. **Case Sensitivity**:
   - Splink typically applies case-insensitive comparisons (e.g., converting strings to lowercase), but spaces are still treated as distinct characters unless explicitly handled.

3. **Token-Based Comparisons**:
   - If the model uses **token-based comparisons** (e.g., splitting names into words), spaces can help separate tokens for better matching (e.g., `Nick Cave` vs. `Nick Cave` matches `Nick` and `Cave` individually).
   - However, mismatched tokenization (e.g., `Nick Cave` vs. `NickCave`) can lead to lower similarity scores or missed matches.

---

### **Would Removing Spaces Improve Performance?**
Removing spaces **could improve performance** in certain cases, but it depends on the matching technique being used:

1. **When Removing Spaces Helps**:
   - **Exact Matching**:
     - If your entity resolution relies heavily on exact matches (e.g., `NickCave` vs. `NickCave`), removing spaces ensures consistent formatting and avoids mismatches caused by whitespace.
   - **String Similarity**:
     - Removing spaces can reduce the edit distance and improve similarity scores for algorithms like Levenshtein or Jaro-Winkler.

2. **When Keeping Spaces Helps**:
   - **Token-Based Matching**:
     - If Splink is configured to perform token-based comparisons (e.g., comparing `Nick` and `Cave` separately), keeping spaces ensures proper tokenization and may improve partial matches.
   - **Human-Readable Data**:
     - Removing spaces can make the data harder to interpret for debugging or manual validation.

---

### **Best Practices for Handling Spaces in Splink**
1. **Preprocessing**:
   - **Normalize Strings**:
     - Convert all strings to lowercase and strip leading/trailing spaces:
       ```python
       df['name'] = df['name'].str.lower().str.strip()
       ```
   - **Remove Internal Spaces** (if exact matching is critical):
     ```python
     df['name'] = df['name'].str.replace(' ', '')
     ```

2. **Custom Comparisons**:
   - Use **Splink's comparison settings** to handle spaces effectively:
     - Apply **string similarity** measures like Jaro-Winkler or Levenshtein distance.
     - Use **token-based comparisons** for multi-word strings.

3. **Experiment with Both Approaches**:
   - Test the model with spaces removed versus spaces preserved to see which configuration yields better results for your dataset.

---

### **Example: Nick Cave vs. nickcave**
#### **With Spaces Preserved**:
- `Nick Cave` vs. `nick cave`:
  - Levenshtein Distance: 1 (due to case difference).
  - Token-Based Matching: High similarity (`Nick` matches `Nick`, `Cave` matches `Cave`).

#### **With Spaces Removed**:
- `NickCave` vs. `nickcave`:
  - Levenshtein Distance: 1 (due to case difference).
  - Exact Matching: Perfect match (`NickCave` == `nickcave`).

---

### **Recommendation**
- If your dataset has **consistent formatting** and spaces are causing issues, consider removing spaces and normalizing strings (e.g., `Nick Cave` → `nickcave`).
- If token-based matching is important (e.g., matching first and last names separately), keep spaces and ensure proper tokenization.

Ultimately, test both approaches to find the best configuration for your specific entity resolution task.

###########################################################

If your **Splink predictions DataFrame** is empty, it means no matches or potential matches were found during the entity resolution process. This can happen for several reasons. Below, I’ll walk you through common causes and what you can do to fix the issue.

---

### **Common Causes for an Empty Predictions DataFrame**
1. **No Matching Records**:
   - The data in your input DataFrame(s) may not have sufficient overlap or similarity for Splink to identify matches.

2. **Overly Strict Thresholds**:
   - The `probability_two_random_records_match` or other thresholds may be set too high, making it difficult for Splink to identify matches.

3. **Inadequate Comparison Rules**:
   - The comparison rules (e.g., string similarity, exact matches) may not be well-suited for the data, causing Splink to miss matches.

4. **Blocking Rules Eliminating Pairs**:
   - Overly restrictive blocking rules may eliminate potential candidate pairs before they are even compared.

5. **Data Quality Issues**:
   - Inconsistent formatting, extra spaces, null values, or case sensitivity in your data can cause Splink to fail to identify matches.

6. **Small Dataset**:
   - If your dataset is very small, there may not be enough pairs for Splink to find matches.

---

### **Steps to Troubleshoot and Fix the Issue**

#### **1. Check Your Input Data**
- Verify that your dataset contains duplicates or near-duplicates for Splink to match.
- Example checks:
  ```python
  print(combined_df.head())
  print(combined_df.info())
  print(combined_df.duplicated())
  ```
- Ensure that the columns being compared (e.g., names, addresses) have meaningful data and are not empty or null.

---

#### **2. Disable Blocking Rules**
- Blocking rules are used to reduce the number of candidate pairs by filtering out unlikely matches. However, overly strict blocking rules can eliminate valid pairs.
- **Solution**: Temporarily disable blocking rules by setting `blocking_rules_to_generate_predictions` to an empty list:
  ```python
  settings = {
      "link_type": "dedupe_only",
      "comparisons": [
          # Define your comparisons here
      ],
      "blocking_rules_to_generate_predictions": []
  }
  ```

---

#### **3. Adjust Comparison Rules**
- Ensure the comparison rules are appropriate for your data. For example:
  - Use **string similarity** measures (e.g., Levenshtein distance, Jaro-Winkler) for text fields with minor variations.
  - Use **exact matches** for fields like email or ID numbers.
- Example comparison configuration:
  ```python
  from splink.comparison_library import levenshtein, exact_match, jaro_winkler

  settings = {
      "link_type": "dedupe_only",
      "comparisons": [
          levenshtein("name", 2),  # Allow for small differences in names
          exact_match("email"),   # Exact match for email
          jaro_winkler("address") # Fuzzy match for address
      ]
  }
  ```

---

#### **4. Lower the Match Threshold**
- The `probability_two_random_records_match` parameter determines how likely it is for two random records to match. If this is set too high, matches may be missed.
- **Solution**: Lower the threshold to make the matching more forgiving:
  ```python
  settings["probability_two_random_records_match"] = 0.01
  ```

---

#### **5. Normalize and Preprocess Your Data**
- Data inconsistencies can prevent matches. Clean and standardize your data before running Splink:
  - Remove extra spaces:
    ```python
    combined_df['name'] = combined_df['name'].str.strip()
    ```
  - Convert text to lowercase:
    ```python
    combined_df['name'] = combined_df['name'].str.lower()
    ```
  - Fill missing values:
    ```python
    combined_df.fillna('', inplace=True)
    ```

---

#### **6. Increase Dataset Size**
- If your dataset is very small (e.g., 10 rows), the number of potential pairs is limited:
  \[
  \text{Number of pairs} = \frac{n \times (n - 1)}{2}
  \]
  For 10 rows, there are only 45 pairs. Adding more rows with duplicates or near-duplicates can improve the likelihood of matches.

---

#### **7. Inspect Pairwise Predictions**
- Check if any pairs were generated but filtered out due to low match probabilities:
  ```python
  linker.predict()
  predictions = linker.predict().as_pandas_dataframe()
  print(predictions)
  ```
- If the predictions DataFrame is empty, it confirms that no pairs met the matching criteria.

---

#### **8. Test with Relaxed Settings**
- Temporarily relax your settings to ensure matches are being generated:
  - Disable blocking.
  - Use lenient comparison rules.
  - Lower thresholds.

---

### **Example Workflow**

Here’s an example workflow to refine your Splink setup:

#### **Step 1: Define Your Data**
```python
import pandas as pd

data = {
    "name": ["Nick Cave", "Nick Cve", "Jon Smith", "John Smith", "Alice Doe", "Alice Do"],
    "email": ["nick@example.com", "nick@example.com", "jon@example.com", "john@example.com", "alice@example.com", "alice@example.com"],
    "address": ["123 Main St", "123 Main St", "456 Elm St", "456 Elm St", "789 Oak St", "789 Oak St"]
}
combined_df = pd.DataFrame(data)
```

#### **Step 2: Configure Splink**
```python
from splink import Splink
from splink.comparison_library import levenshtein, exact_match

settings = {
    "link_type": "dedupe_only",
    "comparisons": [
        levenshtein("name", 2),
        exact_match("email"),
        levenshtein("address", 2)
    ],
    "blocking_rules_to_generate_predictions": [],
    "probability_two_random_records_match": 0.01
}

linker = Splink(combined_df, settings)
```

#### **Step 3: Generate Predictions**
```python
linker.predict()
predictions = linker.predict().as_pandas_dataframe()

if predictions.empty:
    print("No matches found.")
else:
    print(predictions)
```

---

### **Key Takeaways**
- **Clean and preprocess your data** to improve matching.
- **Disable blocking rules** temporarily to ensure no pairs are missed.
- **Adjust thresholds** and comparison rules to make matches more forgiving.
- **Test with larger datasets** to increase the likelihood of finding matches.

################################################

# Assign new sequential unique IDs
combined_df['unique_id'] = range(1, len(combined_df) + 1)


