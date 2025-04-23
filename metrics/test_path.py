import os

file_path = "/Users/amandarodgers/Documents/coding_stuff/data/fake_metrics.csv"
if os.path.exists(file_path):
    print("File exists!")
else:
    print("File does not exist!")
