import pandas as pd

data = {
    'Bank Name': ['Bank A', 'Bank B', 'Bank C'],
    'Routing Number': [111000025, 111000038, 111000123]
}
df = pd.DataFrame(data)

data2 = {
    'Bank Name': ['Bank X', 'Bank Y', 'Bank Z'],
    'Routing Number': [111000025, 111000038, 111000123]
}
csv_df = pd.DataFrame(data2)

# print(df.head())       # Inspect the first few rows of the DataFrame
# print(csv_df.head())   # Inspect the first few rows of the CSV DataFrame

# Merge the DataFrames on Routing Number
merged_df = pd.merge(df, csv_df, on='Routing Number', suffixes=('_df', '_csv'))

# Inspect the merged DataFrame
print(merged_df)
