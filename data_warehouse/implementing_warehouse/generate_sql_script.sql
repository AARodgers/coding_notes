/* To generate sql script to run to format data and insert it

First: load the data file into /home/project:

wget -O file_name.csv url

STEP 1:
# in terminal run the command below to create a new python file
nano generate_sql.py

STEP 2:
# in nano copy and paste this code to format the data to add () and commas
import csv

with open('DimDate.csv', mode='r') as infile, open('insert.sql', mode='w') as outfile:
    reader = csv.reader(infile)
    header = next(reader)

    # Wrap reserved keywords in double quotes
    cols = ', '.join([f'"{h}"' if h in ['Year', 'Quarter', 'Month', 'Day'] else h for h in header])

    outfile.write(f'INSERT INTO dimdate ({cols}) VALUES\n')

    rows = []
    for row in reader:
        formatted_vals = []
        for val in row:
            # Check if the value is numeric; if not, wrap in single quotes
            try:
                float(val)
                formatted_vals.append(val)
            except ValueError:
                formatted_vals.append(f"'{val}'")
        rows.append(f"    ({', '.join(formatted_vals)})")

    outfile.write(',\n'.join(rows) + ';')
print("SQL file generated successfully as insert.sql!")

(Press Ctrl + O then Enter to save,
and Ctrl + X to exit nano if using nano, or just create generate_sql.py via your file explorer).

STEP 3:
# in terminal run the command below to execute the python script and generate the sql file
python3 generate_sql.py
# Verification: The terminal prints SQL file generated successfully as insert.sql!.

STEP 4:
copy and run sql in query tool
open file and copy data or use cat insert.sql and copy/paste into query tool
